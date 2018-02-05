class QuestionAnswerMailer < ApplicationMailer
  def question_subscription(user)
    @greeting = "Hi"

    mail to: user.email
  end
end
