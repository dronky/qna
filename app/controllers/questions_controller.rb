class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :take_question, only: [:show, :destroy, :update]
  after_action :publish_question, only: [:create]
  after_action :publish_comment, only: [:add_comment]

  include VoteFeatures
  include CommentFeature

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.attachments.build
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
    @answer = @question.answers.create(question: @question, user: current_user)
    @answer.attachments.build
  end

  def update
    @question.user = current_user
    @question.update(question_params)
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to new_user_session_path
    end
  end


  private

  def take_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :comment, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
        'questions',
        ApplicationController.render(
            partial: 'questions/question',
            locals: {question: @question, current_user: @question.user})
    )
  end

  def publish_comment
    @question = Question.find(params[:id])
    ActionCable.server.broadcast(
        "comments_question_#{@question.id}",
        {question_id: @question.id, type: 'question', body:
            ApplicationController.render(
                partial: 'questions/comment_for_websocket',
                locals: {comment: @question.comments.last})
        })



    #
    # {question_id: @question.id, body:
    #     ApplicationController.render(
    #         partial: 'questions/comment_for_websocket',
    #         locals: {comment: @question.comments.last})
    # })
  end
end
