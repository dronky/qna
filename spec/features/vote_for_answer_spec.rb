require 'rails_helper'

feature 'Vote answer' do

  given(:user) {create(:user)}
  given(:user2) {create(:user)}
  given(:question) {create(:question)}


  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Up vote for the answer created by user', js: true do
    click_on 'Answer on it'
    fill_in 'answer_body', with: 'rspec test'
    click_on 'Create Answer'

    within "#list_of_answers" do
      click_on '+'

      expect(page).to have_content "Result:0"
    end
  end

  scenario 'Up vote for the answer', js: true do
    click_on 'Answer on it'
    fill_in 'answer_body', with: 'rspec test'
    click_on 'Create Answer'
    click_on 'Logout'

    sign_in(user2)
    visit question_path(question)

    within "#list_of_answers" do
      click_on '+'

      expect(page).to have_content "Result:1"
    end
  end

  scenario 'Double Up vote for the answer', js: true do
    click_on 'Answer on it'
    fill_in 'answer_body', with: 'rspec test'
    click_on 'Create Answer'
    click_on 'Logout'

    sign_in(user2)
    visit question_path(question)

    within "#list_of_answers" do
      click_on '+'
      click_on '+'

      expect(page).to have_content "Result:1"
    end
  end

end