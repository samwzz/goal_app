require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content 'NEW USER'
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: 'test_name'
      fill_in 'Password', with: 'password'
      click_on 'Submit'
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "Home Page"
    end
  end

end

feature "logging in" do
  let (:user) {FactoryGirl.create(:user, username: 'boss_user', password: 'password')}

  scenario "shows username on the homepage after login" do
    #what is login_as?
    login_as(user)
    expect(page).to have_content "Hello boss_user"
  end
end

feature "logging out" do

  scenario "begins with a logged out state"

  scenario "doesn't show username on the homepage after logout"

end
