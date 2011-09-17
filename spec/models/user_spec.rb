require 'spec_helper'

describe User do

  describe "Github validations" do
    before(:each) do
      @user = User.new(:email => "test@example.com",:password => "123456",:password_confirmation => "123456")
    end
    
    it "should check Github credentials if present" do
      @user.github_username.should be_nil
      @user.github_api_key.should be_nil

      @user.github_username = "test"
      @user.github_api_key = "0123456789abcdef0123456789abcdef"

      @user.has_github_credentials?.should be_true
      @user.github_credentials_changed?.should be_true

      VCR.use_cassette('github/has_valid_github_credentials/valid') do
        @user.should be_valid
      end
    end

    it "should check for invalid credentials" do
      @user.github_username = "test"
      @user.github_api_key = "0123456789abcdef0123456789abcdef"

      @user.errors.should_receive(:add).with(:github_username,:authentication_failure)

      VCR.use_cassette('github/has_valid_github_credentials/invalid') do
        @user.valid?
      end
    end

    it "should not hit Github API if credentials not present" do
      @user.has_github_credentials?.should be_false

      @user.should_not_receive(:has_valid_github_credentials?)
      @user.valid?
    end

    it "should not hit Github API if credentials have not changed" do
      @user.github_username = "test"
      @user.github_api_key = "0123456789abcdef0123456789abcdef"
      @user.github_credentials_changed?.should be_true
      
      @user.should_receive(:has_valid_github_credentials?).and_return(true)
      @user.save!
      @user.reload

      @user.github_username = "test"
      @user.github_api_key = "0123456789abcdef0123456789abcdef"
      @user.github_credentials_changed?.should be_false

      @user.should_not_receive(:has_valid_github_credentials?)
      @user.save!
    end

  end

end