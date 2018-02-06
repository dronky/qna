class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    alias_action :plus_vote, :minus_vote, :to => :vote
    guest_abilities
    can :me, User
    can :create, [Question, Answer, Comment, Subscription]
    can [:update, :destroy], [Question, Answer], user_id: user.id
    can [:vote], [Question, Answer]
    can [:destroy], Subscription, user_id: user.id
    cannot :vote, [Question, Answer], user_id: user.id
    can :mark_as_best, Answer do |a|
      a.question.user_id == user.id
    end
  end
end
