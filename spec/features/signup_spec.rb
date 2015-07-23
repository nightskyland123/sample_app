require "rails_helper"

RSpec.describe "User sign up", type: :feature do
  
  before(:each) do
    Capybara.current_driver = :selenium
  end
  
  let(:custom_path) do
    "http://localhost:3000/signup"
  end
  
  it "should have sign up form" do
    visit custom_path
    expect(page).to  have_field "user[name]"
    expect(page).to  have_field "user[email]"
    expect(page).to  have_field "user[password]"
    expect(page).to  have_field "user[password_confirmation]"
    expect(page).to  have_button "Create User"
  end
  
  it "should create new user" do
    visit signup_path
    fill_in "user_name", with: "new user"
    fill_in "user_email", with: "newuser@test.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    click_button "Create User"
    expect(page).to have_css "p", text: "User was successfully created"
  end  
end