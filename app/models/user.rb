class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :github_username, :github_api_key

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

end
