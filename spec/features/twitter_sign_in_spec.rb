require 'rails_helper'

describe "access top page" do

  before(:each) do
    visit root_path
    click_link 'Login'
  end

  it "can sign in user with Twitter account" do
    page.should have_content("Sign in with Twitter")
    twitter_mock_auth_hash
    click_link 'Sign in with Twitter'
    fill_in 'email', with: 'rzd@oao-rzd.ru'
    click_on 'Send'
    open_email('rzd@oao-rzd.ru')
    current_email.click_link 'Confirm my account'
    click_on 'Sign in with Twitter'
    page.should have_content("rzd@oao-rzd.ru")  # user email
    page.should have_content("Twitter")  # auth provider
    page.should have_content("Logout")
  end

  it "can handle authentication error" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_link "Sign in with Twitter"
    page.should have_content('Invalid credentials')
  end
end