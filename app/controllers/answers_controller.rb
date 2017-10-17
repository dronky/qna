class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :destroy]
  before_action :take_question
  before_action :take_answer, only: [:show]

  def index
    @answers = current_user.answers.all
  end

  def new
    @answer = current_user.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def show
  end

  def destroy
    @question.answers.find_by_id(params[:id]).destroy
    redirect_to question_path(@question)
  end

  private

  def take_answer
    @answer = current_user.answers.find_by_id(params[:id])
  end

  def take_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
