require 'rails_helper'

feature 'Questions flow', %q{
  - Signed in user tries to create question
  - Signed out user tries to create question
} do

  scenario 'Signed in user tries to create question ' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    click_link 'Create question'

    visit new_question_path
    fill_in 'Title', with: 'rspec'
    fill_in 'Body of question', with: 'rspec test'
    click_on 'Create Question'

    expect(page).to have_content 'List of questions'
    expect(page).to have_css('table td', count: 4)
  end

  scenario 'Not a user tries to create question ' do

    visit root_path
    click_link 'Create question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end

  # given!(:user) {create(:user)} уточнить, почему при попытке залогиниться юзером из фабрики всегда показывает ошибку Invalid email or password

  scenario 'Only author can edit own question', js:true do
    # sign_in user уточнить почему-то не подтягивается макрос на sign_in, конфиг кажется нормально настроенным
    user = User.create!(email: 'test@test.com', password: '123456')
    question = Question.create!(body: 'test', title: 'Test1', user: user)

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit question_path(question)
    click_on 'Edit'
    fill_in 'question_title', with: 'title'
    fill_in 'question_body', with: 'body'
    click_on 'Update Question'

    expect(page).to_not have_content question.body
  end

  scenario 'Author is able to mark answer as a best', js: true do
    user = User.create!(email: 'test@test.com', password: '123456')
    question = Question.create!(body: 'test', title: 'Test1', user: user)
    Answer.create(body: 'test', question: question, user: user)
    Answer.create(body: 'test2', question: question, user: user)

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit question_path(question)
    first(:link, 'Mark as a best answer').click

    expect(page).to have_content 'This is a best answer'
    expect(page).to have_selector('td:nth-of-type(5)', text: 'This is a best answer')
    expect(page).to have_selector('td:nth-of-type(5)', text: 'This is a best answer', count: 1)
  end
end