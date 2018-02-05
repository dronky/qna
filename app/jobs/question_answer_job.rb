class QuestionAnswerJob < ApplicationJob
  queue_as :default

  def perform(question)
    question.subscriptions.each do |sub|
      QuestionAnswerMailer.question_subscription(sub.user).deliver_later
    end
  end
end
