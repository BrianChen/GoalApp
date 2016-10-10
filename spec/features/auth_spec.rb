require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("New User")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', with: "Alex"
      fill_in 'password', with: "alex123"
      click_on 'Sign Up'
      expect(page).to have_content("Alex")
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    visit new_user_url
    fill_in 'username', with: "Alex"
    fill_in 'password', with: "alex123"
    click_on 'Sign Up'
    expect(page).to have_content("Alex")
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit new_session_url
    expect(page).to have_content("Sign In")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in 'username', with: "Bob"
    fill_in 'password', with: "bob123"
    click_on 'Sign In'
    click_on 'Sign Out'

    expect(page).to_not have_content("Alex")

  end

end
