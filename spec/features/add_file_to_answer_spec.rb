require 'rails_helper'

feature 'Add file to the answer', %q{
  User is able to add the file to his answer
} do

  given(:user) {create(:user)}
  given(:question) {create(:question, user: user)}

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Answer owner adds file' do
    click_on 'Answer on it'
    fill_in 'answer_body', with: 'rspec test'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create Answer'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end

end