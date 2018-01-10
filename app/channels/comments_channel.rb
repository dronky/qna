class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "comments_question_#{data['id']}"
  end
end