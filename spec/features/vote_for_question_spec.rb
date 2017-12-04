require 'rails_helper'

feature 'Vote question' do

  given(:user) {create(:user)}
  given(:question) {create(:question)}
  given(:question2) {create(:question, user: user)}


  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Up vote for the question', js: true do
    within "#question_vote-#{question.id}" do
      click_on '+'

      expect(page).to have_content "Result:1"
    end
  end

  scenario 'Up vote for the question', js: true do
    within "#question_vote-#{question.id}" do
      click_on '+'
      click_on '+'

      expect(page).to have_content "Result:1"
    end
  end

  scenario 'Up vote for the question created by user', js: true do
    visit question_path(question2)

    within "#question_vote-#{question2.id}" do
      click_on '+'

      expect(page).to have_content "0"
    end
  end

end