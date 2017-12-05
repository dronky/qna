class Question < ApplicationRecord
  include Votable

  has_many :answers
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

end
