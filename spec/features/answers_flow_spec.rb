require 'rails_helper'

feature 'Answer flow', %q{
  - Signed in user tries to leaves an answer
} do

  scenario 'Signed in user tries to leaves an answer', js: true do
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
    fill_in 'answer_body', with: 'rspec test'
    click_on 'Create Answer'

    expect(page).to have_content 'rspec test'

  end

  scenario 'Signed in user can see question and its answers', js: true do
    user = User.create!(email: 'test@test.com', password: '123456')
    question = user.questions.create!(title: 'rspec', body: 'rspec test')

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit question_path(question)
    click_on 'Answer on it'
    fill_in 'answer_body', with: 'rspec test'
    click_on 'Create Answer'

    expect(page).to have_content 'rspec test'
    expect(current_path). to eq question_path(question)
  end

  scenario 'Author is able to edit only his own answer', js: true do
    user = User.create!(email: 'test@test.com', password: '123456')
    question = Question.create!(body: 'test', title: 'Test1', user: user)
    answer = Answer.create(body: 'test', question: question, user: user)

    visit root_path
    click_link 'Login'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit question_path(question)
    click_on 'Answer on it'
    fill_in 'answer_body', with: 'rspec test'
    click_on 'Create Answer'

    within '#list_of_answers' do
      click_on 'Edit'
      fill_in 'answer_body', with: 'rspec test'

      expect(page).to have_content 'rspec test'
    end
  end

end