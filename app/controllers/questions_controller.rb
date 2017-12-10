class QuestionsController < ApplicationController
  before_action :take_question, only: [:show]

  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :index
    end
  end

  def show
  end

  private

  def take_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end

