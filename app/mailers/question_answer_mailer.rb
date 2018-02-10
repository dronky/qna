class QuestionAnswerMailer < ApplicationMailer
  def question_subscription(sub)
    @question = sub.question
    mail to: sub.user.email
  end
end
