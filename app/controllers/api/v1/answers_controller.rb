class Api::V1::AnswersController < Api::V1::BaseController
  before_action :take_question, only: :create
  authorize_resource

  def index
    @answers = Answer.all
    respond_with @answers, each_serializer: AnswerCollectionSerializer
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def create
    @answer = current_resource_owner.answers.create(answer_params.merge(question_id: @question.id))
    respond_with @answer
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def take_question
    @question = Question.find(params[:question_id])
  end
end