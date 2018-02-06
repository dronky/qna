class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :take_subscription, only: :destroy
  before_action :take_question, only: :create

  authorize_resource

  respond_to :js

  def create
    @subscription = current_user.subscriptions.create(question: @question)
    respond_with @subscription
  end

  def destroy
    respond_with(@subscription.destroy)
  end

  private

  def take_question
    @question = Question.find(params[:question])
  end

  def take_subscription
    @subscription = Subscription.find(params[:id])
  end
end