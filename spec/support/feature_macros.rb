module FeatureMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def login
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end
end