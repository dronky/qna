class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true
  scope :best_answer, -> {
    where(:best_answer => true)
  }
  scope :best_answer_first, -> {best_answer ? order(best_answer: :desc) : order(best_answer: :asc)}
end
