class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_one :vote, as: :votable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  scope :best_answer, -> {
    where(best_answer: true)
  }

  scope :best_answer_first, -> {best_answer ? order(best_answer: :desc) : order(best_answer: :asc)}

  @counter = vote.sum # вот на этой строчке валится с ошибкой
  # NameError: undefined local variable or method `vote' for #<Class:0x007fe7febe5f80>
  # хотя ассоциация выше есть

  def best_answer_flag
    transaction do
      question.answers.update_all(best_answer: false)
      update!(best_answer: true)
    end
  end

  def add_vote(user)
    vote.sum += 1 # вот этот код отработает?
    set_vote(@counter, user)
  end

  def down_vote(user)
    vote.sum -= 1
    set_vote(@counter, user)
  end

  private

  def set_vote(value, user)
    if vote.where(user: user).exists?
      vote.update_attributes(sum: @counter)
    else
      vote.create!(sum: value, user: user)
    end
  end
end

