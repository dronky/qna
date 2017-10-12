require 'rails_helper'

feature 'Answer flow', %q{
  - Signed in user tries to leaves an answer
} do

  scenario 'Signed in user tries to leaves an answer' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit new_question_path
    fill_in 'Title', with: 'rspec'
    fill_in 'Body of question', with: 'rspec test'
    click_on 'Create Question'
    click_on 'Show'
    click_on 'Answer on it'
    fill_in 'body', with: 'rspec test'
    click_on 'Save changes'

    expect(page).to have_content 'rspec test'

  end

  scenario 'Signed in user can see question and its answers' do
    user = User.create!(email: 'test@test.com', password: '123456')
    question = user.questions.create!(title: 'rspec', body: 'rspec test')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit question_path(question)
    click_on 'Answer on it'
    fill_in 'body', with: 'rspec test'
    click_on 'Save changes'

    expect(page).to have_content 'rspec test'
    expect(current_path). to eq question_path(question)
  end

end