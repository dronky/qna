require 'rails_helper'

feature 'Search' do

  given(:user) {create(:user)}

  background do
    sign_in(user)
  end

  let!(:question) {create(:question)}
  scenario 'User using question search', js: true do
    ThinkingSphinx::Test.run do
      visit questions_path
      within '.search-form' do
        fill_in 'query', with: 'MyString'
        select 'Question', from: 'resource'
        click_on 'Search'
      end
      # Body of question
      expect(page).to have_content 'MyText'
    end
  end
  let!(:answer) {create(:answer)}
  scenario 'User using answer search', js: true do
    ThinkingSphinx::Test.run do
      visit questions_path
      within '.search-form' do
        fill_in 'query', with: 'MyText'
        select 'Answer', from: 'resource'
        click_on 'Search'
      end
      expect(page).to have_content 'MyText'
    end
  end
end