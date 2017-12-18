module CommentFeature
  extend ActiveSupport::Concern

  included do
    before_action :set_commentable, only: [:add_comment]
  end

  def add_comment
    @commentable.add_comment(params[:comment])
    render json: @commentable.as_json(methods: :get_comment)
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_commentable #сделать через case-when
    controller_name == "answers" ? @commentable = model_klass.find(params[:answer_id]) : @commentable = model_klass.find(params[:id])
  end
end