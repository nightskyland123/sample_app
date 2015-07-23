require "rails_helper"

RSpec.describe "User sign in", type: :feature do
  
  before(:each) do
    Capybara.current_driver = :selenium
  end
  
  it "should have sign in form" do
    visit signin_path
    expect(page).to  have_field "session[email]"
    expect(page).to  have_field "session[password]"
  end
  
  it "should signed in if user already exist" do
    #sign up user first
    visit signup_path
    fill_in "user_name", with: "new user"
    fill_in "user_email", with: "newuser@test.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Create User"
    
    #sign in user
    visit signin_path
    fill_in "session_email", with: "newuser@test.com"
    fill_in "session_password", with: "123456"
    click_button "Sign in"
    
    expect(page).to have_css "p", text: "new user"
    expect(page).to have_css "p", text: "newuser@test.com"
  end
end