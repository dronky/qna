class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!
  respond_to :json

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  protected

  def current_ability
    @ability ||= Ability.new(current_resource_owner)
  end
end