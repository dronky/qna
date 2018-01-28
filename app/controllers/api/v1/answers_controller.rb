class Api::V1::AnswersController < Api::V1::BaseController
  def index
    @answers = Answer.all
    respond_with @answers, each_serializer: AnswerCollectionSerializer
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  private

  def answer_params
    params.require(:question).permit(:title, :body)
  end
end