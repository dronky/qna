FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    user
  end

  factory :question_edited, class: 'Question' do
    title "MyString new"
    body "MyText new"
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
