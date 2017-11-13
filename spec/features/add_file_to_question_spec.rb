require 'rails_helper'

feature 'Add file to the question', %q{
  User is able to add the file to his question
} do

  given(:user) {create(:user)}

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Question owner adds file', js: true do
    fill_in 'Title', with: 'rspec'
    fill_in 'Body of question', with: 'rspec test'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'add file'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Create Question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end

end