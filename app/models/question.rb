class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  has_many :attachments, as: :attachmentable

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
