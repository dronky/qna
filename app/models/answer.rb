class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  scope :best_answer, -> {
    where(best_answer: true)
  }

  scope :best_answer_first, -> {best_answer ? order(best_answer: :desc) : order(best_answer: :asc)}

  def best_answer_flag
    transaction do
      question.answers.update_all(best_answer: false)
      update!(best_answer: true)
    end
  end

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
    votes.sum(:sum)
  end

  def reset_vote(user)
    if votes.where(user_id: user.id).exists?
      votes.where(user_id: user.id).destroy_all
    end
  end
end
