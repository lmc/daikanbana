class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :github_username, :github_api_key

  validate :validate_github_credentials, :if => :has_github_credentials?
  validates :github_api_key, :format => { :with => /\A[0-9a-f]{32}\Z/ } #md5 hash

  state_machine :status, :initial => :unregistered do
    state :unregistered

    state :unverified

    state :verified


    event :register do
      transition :unregistered => :unverified
    end

    event :verify do
      transition :unverified => :verified
    end
  end


  def has_github_credentials?
    !!(github_username && github_api_key)
  end

  def has_valid_github_credentials?
    return false unless has_github_credentials?
    #following yourself is a no-op, but still validates login
    !!github_client.follow(github_username)
  rescue Octokit::Unauthorized
    false
  end

  def github_client
    Octokit::Client.new(:login => self.github_username, :token => self.github_api_key)
  end


  protected

  def validate_github_credentials
    errors.add(:github_username,:authentication_failure) unless has_valid_github_credentials?
  end

end
