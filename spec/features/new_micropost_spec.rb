require "rails_helper"

RSpec.describe "Create new micropost", type: :feature do
  
  before(:each) do
    Capybara.current_driver = :selenium
  end
  
  it "should have new micropost form" do
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
   
    #go to micropost page
    visit new_micropost_path
    expect(page).to  have_field "micropost[content]"    
    expect(page).to  have_button "Create Micropost"
  end
  
  it "should have create micropost if input valid" do
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
    
    #go to micropost page
    visit new_micropost_path
    fill_in "micropost_content", with: "new micropost test"
    click_button "Create Micropost"
    
    expect(page).to have_css "p", text: "new micropost test"
  end
  
  it "should have create micropost if input invalid" do
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
    
    #go to micropost page
    visit new_micropost_path
    fill_in "micropost_content", with: ""
    click_button "Create Micropost"
    
    expect(page).to have_css "li", text: "Content can\'t be blank"
    expect(page).to have_css "li", text: "Content is too short (minimum is 1 character)"
  end
end