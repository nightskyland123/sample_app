require "rails_helper"

RSpec.describe "Delete existing comment", type: :feature do
  
  before(:each) do
    Capybara.current_driver = :selenium
  end
  
  it "unable to delete someone else comment" do
    #sign up first user
    visit signup_path
    fill_in "user_name", with: "new user"
    fill_in "user_email", with: "newuser@test.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Create User"
    
    #sign up second user
    visit signup_path
    fill_in "user_name", with: "new user2"
    fill_in "user_email", with: "newuser2@test.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Create User"
    
    #sign in first user
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
    
    #sign out first user
    click_link "Sign out"
    
    #sign in second user
    visit signin_path
    fill_in "session_email", with: "newuser2@test.com"
    fill_in "session_password", with: "123456"
    click_button "Sign in"
    
    #visit first user's micropost
    visit microposts_path
    click_link "Show"
    expect(page).not_to have_link "Destroy"
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
    
    #delete comment
    first(:link, "Destroy").click
    confirmdestroy = page.driver.browser.switch_to.alert
    if confirmdestroy.text == 'Are you sure?'
      confirmdestroy.accept
    end
    expect(page).to have_css "p", text: "Comment was successfully destroyed."
  end
end