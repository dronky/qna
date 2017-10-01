class Answer < ApplicationRecord
  has_one :question
  validates :body, presence: true
end
