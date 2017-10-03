class QuestionsController < ApplicationController
  before_action :take_question, only: [:show]

  def index
    @questions = Question.all
  end

  def show

  end

  private

  def take_question
    @question = Question.find(params[:id])
  end
end

