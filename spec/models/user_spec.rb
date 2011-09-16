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

      @user.should_receive(:has_valid_github_credentials?).and_return(true)
      @user.should be_valid
    end

  end

end