require 'spec_helper'

feature "new user registration" do
  before :each do
    visit new_user_registration_path
  end

  it "should sign up successfully" do
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password (confirm)", :with => "password"

    lambda {
      click_button :commit
    }.should change(User,:count).by(1)

    User.last.tap do |user|
      user.email.should == "test@example.com"
      user.valid_password?("password").should be_true
      user.should be_unverified
    end
  end

  it "should report errors if sign up is not successful" do
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password (confirm)", :with => "not the password"

    lambda {
      click_button :commit
    }.should_not change(User,:count)

    page.should_not have_css("form#new_user #user_email_input.error")
    page.should have_css("form#new_user #user_password_input.error")
    page.should have_content("doesn't match confirmation")
  end
end