class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true
  validates :best_answer, uniqueness: {scope: :question_id}
end
