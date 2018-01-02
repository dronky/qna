class AnswersChannel < ApplicationCable::Channel
  def follow_answer(id)
    stream_from "question_#{id}"
  end
end