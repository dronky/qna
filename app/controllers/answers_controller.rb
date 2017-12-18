class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :take_question
  before_action :take_answer, only: [:show, :destroy, :mark_as_best]
  after_action :publish_answer, only: [:create]
  after_action :publish_comment, only: [:add_comment]
  protect_from_forgery except: :mark_as_best

  include VoteFeatures
  include CommentFeature

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
    if !current_user.author_of?(@answer)
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
    @answer = Answer.find(params[:id])
    @answer.best_answer_flag
  end

  private

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
        'answers',
        ApplicationController.render(
            partial: 'questions/answer',
            locals: {answer: @answer, current_user: @answer.user})
    )
  end

  def publish_comment
    @answer = Answer.find(params[:answer_id])
    return if @answer.errors.any?
    ActionCable.server.broadcast(
        'answer_comments',
        {answer_id: @answer.id, body:
        ApplicationController.render(
            partial: 'questions/comment_for_websocket',
            locals: {comment: @answer.comments.last})
        })
  end
end
