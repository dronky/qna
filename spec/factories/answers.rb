FactoryGirl.define do
  factory :answer do
    body "MyText"
    question
    user
  end

  factory :answer_2, class: 'Answer' do
    body "MyText2"
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
    user
  end

  factory :invalid_answer_whithout_user, class: 'Answer' do
    body "MyText"
    question
  end
end
