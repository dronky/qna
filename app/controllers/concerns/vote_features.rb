module VoteFeatures
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:plus_vote, :minus_vote, :reset_votes]
  end

  def plus_vote
    if !current_user.author_of?(@votable)
      @votable.add_vote(current_user)
      render json: @votable.as_json(methods: :get_vote)
    end
  end

  def minus_vote
    if !current_user.author_of?(@votable)
      @votable.down_vote(current_user)
      render json: @votable.as_json(methods: :get_vote)
    end
  end

  def reset_votes
    if current_user.author_of?(@votable)
      @votable.reset_vote(current_user)
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end