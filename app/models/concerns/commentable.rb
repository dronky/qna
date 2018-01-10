module Commentable
  extend ActiveSupport::Concern

  def add_comment(body)
    comments.create!(body: body)
  end

  def get_comment
    comments.last.body
  end
end