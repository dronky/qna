class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :destroy]
  before_action :take_question
  before_action :take_answer, only: [:show, :destroy, :update]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def show
  end

  def update
    Answer.find(params[:id]).update(answer_params)
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def mark_as_best
    @question.answers.best_answer.each do |answer|
      answer.best_answer = false
      answer.save
    end
    @answer = Answer.find(params[:id])
    @answer.best_answer = true
    @answer.save
  end

  private

  def take_answer
    @answer = current_user.answers.find(params[:id])
  end

  def take_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
