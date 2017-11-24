class Question < ApplicationRecord
  has_many :answers
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  def add_vote(user)
    set_vote(1, user)
  end

  def down_vote(user)
    set_vote(-1, user)
  end

  # private

  def set_vote(value, user)
    if votes.where(votable_id: id, user_id: user).exists?
      votes.create!(sum: value, user_id: user.id, clicked: true) unless votes.where(user_id: user.id).first.clicked
    else
      votes.create!(sum: value, user_id: user.id, clicked: true)
    end
  end

  def get_vote
    if votes.where(votable_id: id).exists?
      votes.where(votable_id: id).sum(:sum)
    else
      0
    end
  end
end
