require "rails_helper"

RSpec.describe "Create new comment", type: :feature do
  
  before(:each) do
    Capybara.current_driver = :selenium
  end
  
  it "should have a new comment form" do
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
    
    #add new comment
    click_link "Add Comment"
    expect(page).to  have_css "h1", text: "New Comment"
    expect(page).to  have_field "comment[content]"
    expect(page).to  have_button "Save Comment"
  end
  
  it "should have created a comment if the input valid" do
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
    
    #add new comment
    click_link "Add Comment"
    fill_in "comment_content", with: "new comment test"
    click_button "Save Comment"
    expect(page).to have_css "p", text: "Comment was successfully created."
  end
  
  it "should have shown error messages if the comment invalid" do
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
    
    #add new comment
    click_link "Add Comment"
    fill_in "comment_content", with: ""
    click_button "Save Comment"
    expect(page).to have_css "li", text: "Content can\'t be blank"
    expect(page).to have_css "li", text: "Content is too short (minimum is 1 character)"
  end
end