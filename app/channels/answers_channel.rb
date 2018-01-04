class AnswersChannel < ApplicationCable::Channel
  def follow_answer(data)
    stream_from "question_#{data['id']}"
  end
end