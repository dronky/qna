class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :destroy]
  before_action :take_question
  before_action :take_answer, only: [:show, :destroy, :mark_as_best]
  protect_from_forgery except: :mark_as_best


  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def new
    @answer = @question.answers.new
    @answer.user = current_user
  end

  def show
  end

  def update
    @answer = Answer.find(params[:id])
    if current_user == nil || !current_user.author_of?(@answer)
      redirect_to new_user_session_path
    else
      @answer.update(answer_params)
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def mark_as_best
    Answer.find(params[:id]).best_answer_flag
  end

  private

  def take_answer
    @answer = current_user.answers.find_by(id: params[:id])
  end

  def take_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
