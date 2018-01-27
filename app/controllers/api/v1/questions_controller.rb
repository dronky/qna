class Api::V1::QuestionsController < Api::V1::BaseController
  def index
    @questions = Question.all
    #include will include associated resources
    respond_with @questions, each_serializer: QuestionCollectionSerializer
  end

  def show
    @question = Question.find(params[:id])
    respond_with @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end