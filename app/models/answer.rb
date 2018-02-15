class Answer < ApplicationRecord
  include Votable
  include Commentable

  belongs_to :question, touch: true
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  after_create :send_notification
  after_save ThinkingSphinx::RealTime.callback_for(:answer)

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  scope :best_answer, -> {
    where(best_answer: true)
  }

  scope :best_answer_first, -> {best_answer ? order(best_answer: :desc) : order(best_answer: :asc)}

  def send_notification
    QuestionAnswerJob.perform_later(question)
  end

  def self.get_question(answer_id)
    Answer.find(answer_id).question
  end

  def best_answer_flag
    transaction do
      question.answers.update_all(best_answer: false)
      update!(best_answer: true)
    end
  end
end
