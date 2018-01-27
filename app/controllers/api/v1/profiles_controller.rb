class Api::V1::ProfilesController < Api::V1::BaseController


  def me
    respond_with current_resource_owner
  end

  def index
    respond_with User.all_except(current_resource_owner)
  end


end