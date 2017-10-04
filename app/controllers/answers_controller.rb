class AnswersController < ApplicationController
  before_action :take_question
  before_action :take_answer, only: [:show]

  def index
    @answers = @question.answers.all
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_answers_path
    else
      render :index
    end
  end

  def show
  end

  private

  def take_answer
    @answer = @question.answers.find(params[:id])
  end

  def take_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:question_id, :body)
  end
end
