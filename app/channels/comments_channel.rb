class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "comments_#{data['type']}_#{data['id']}"
  end
end