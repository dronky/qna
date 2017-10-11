class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :take_question, only: [:show, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :index
    end
  end

  def show
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def take_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
