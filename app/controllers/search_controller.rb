class SearchController < ApplicationController
  authorize_resource class: :controller

  def search
    resource = params[:resource].constantize
    @results = resource.search params[:query], per_page: params[:limit], page: params[:page]
    if @results.empty?
      flash[:notice] = "Nothing found"
      redirect_to root_path
    end
  end

  private

  def search_params
    params.require(:search).permit(:query, :resource, :limit, :page)
  end

end
