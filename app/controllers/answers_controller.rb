class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :take_question, only: [:create, :new, :mark_as_best]
  before_action :take_answer, only: [:show, :update, :destroy, :mark_as_best]
  before_action :find_answer, only: :mark_as_best
  after_action :publish_answer, only: [:create]
  after_action :publish_comment, only: [:add_comment]
  protect_from_forgery except: :mark_as_best

  include VoteFeatures
  include CommentFeature

  authorize_resource

  respond_to :js, :html

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def new
    respond_with(@question.answers.new)
  end

  def show
  end

  def update
      @answer.update(answer_params)
      respond_with(@answer)
  end

  def destroy
    respond_with(@answer.destroy)
  end

  def mark_as_best
    respond_with(@answer.best_answer_flag)
  end

  private

  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

  def take_answer
    @answer = current_user.answers.find_by(id: params[:id])
  end

  def take_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
        "question_#{@question.id}",
        ApplicationController.render(
            partial: 'questions/answer',
            locals: {answer: @answer, current_user: @answer.user})
    )
  end

  def publish_comment
    @answer = Answer.find(params[:answer_id])
    return if @answer.errors.any?
    ActionCable.server.broadcast(
        "comments_question_#{@answer.question.id}",
        {question_id: @answer.question.id, id: @answer.id, type: 'answer', body:
            ApplicationController.render(
                partial: 'questions/comment_for_websocket',
                locals: {comment: @answer.comments.last})
        })
  end
end
