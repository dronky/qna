class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, optional: true, touch: true
  after_save ThinkingSphinx::RealTime.callback_for(:comment)

end
