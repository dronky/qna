class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments
  validates :body, presence: true

  scope :best_answer, -> {
    where(best_answer: true)
  }

  scope :best_answer_first, -> {best_answer ? order(best_answer: :desc) : order(best_answer: :asc)}

  def best_answer_flag
    transaction do
      question.answers.update_all(best_answer: false)
      update(best_answer: true)
    end
  end
end

