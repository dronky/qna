require 'rails_helper'

describe "access top page" do

  before(:each) do
    visit root_path
    click_link 'Login'
  end

  it "can sign in user with Facebook account" do
    page.should have_content("Sign in with Facebook")
    fb_mock_auth_hash
    click_link 'Sign in with Facebook'
    open_email('belozerov@rzd.ru')
    current_email.click_link 'Confirm my account'
    click_on 'Sign in with Facebook'
    page.should have_content("belozerov@rzd.ru")  # user email
    page.should have_content("Facebook")  # auth provider
    page.should have_content("Logout")
  end

  it "can handle authentication error" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    click_link "Sign in with Facebook"
    page.should have_content('Invalid credentials')
  end
end