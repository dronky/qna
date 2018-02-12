require 'rails_helper'

feature 'Devise flow', %q{
  Sign in
  Sign out
  Log in
  Log out
} do
  scenario 'Registered user tries to log in' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end


  scenario 'Registered user tries to log out' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    click_link 'Logout'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Unregistered user tries to log in' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test1@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq new_user_session_path
  end
  scenario 'Unregistered user tries to sign up' do
    # User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_link 'Login'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end
end