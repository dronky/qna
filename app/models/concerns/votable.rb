module Votable
  extend ActiveSupport::Concern

  def add_vote(user)
    set_vote(1, user)
  end

  def down_vote(user)
    set_vote(-1, user)
  end

  def reset_vote(user)
    if votes.where(user: user).exists?
      votes.where(user: user).destroy_all
    end
  end

  def get_vote
    votes.sum(:sum)
  end

  private

  def set_vote(value, user)
    if votes.where(user: user).exists?
      votes.create!(sum: value, user: user, clicked: true) unless votes.where(user: user).first.clicked
    else
      votes.create!(sum: value, user: user, clicked: true)
    end
  end
end