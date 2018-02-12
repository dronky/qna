class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :title, :body, presence: true
  after_save ThinkingSphinx::RealTime.callback_for(:question)

  after_create :subscribe

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  def subscribe
    subscriptions.create(user: user)
  end

  def self.latest
    where("created_at > ?", 1.day.ago)
  end

end
