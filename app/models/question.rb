class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

end
