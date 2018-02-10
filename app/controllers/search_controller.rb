class SearchController < ApplicationController
  authorize_resource class: :controller

  def search
    resource = params[:resource].constantize
    @results = resource.search params[:query], per_page: params[:limit], page: params[:page]
    # redirect_to search_path
  end

  private

  def search_params
    params.require(:search).permit(:query, :resource, :limit, :page)
  end

end
