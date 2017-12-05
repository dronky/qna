module Votable
  extend ActiveSupport::Concern

  def add_vote(user)
    set_vote(1, user)
  end

  def down_vote(user)
    set_vote(-1, user)
  end

  def reset_vote(user)
    if votes.where(user_id: user.id).exists?
      votes.where(user_id: user.id).destroy_all
    end
  end

  def get_vote
    votes.sum(:sum)
  end

  private

  def set_vote(value, user)
    if votes.where(votable_id: id, user_id: user).exists?
      votes.create!(sum: value, user_id: user.id, clicked: true) unless votes.where(user_id: user.id).first.clicked
    else
      votes.create!(sum: value, user_id: user.id, clicked: true)
    end
  end
end