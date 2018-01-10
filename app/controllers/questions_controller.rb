class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :take_question, only: [:show, :destroy, :update]
  after_action :publish_question, only: [:create]
  after_action :publish_comment, only: [:add_comment]
  before_action :build_answer, only: :show

  include VoteFeatures
  include CommentFeature

  def index
    respond_with(@questions = Question.all)
  end

  def new
    respond_with (@question = Question.new)
  end

  def create
    respond_with (@question = current_user.questions.create(question_params))
  end

  def show
    @answer.attachments.build
    respond_with @question
  end

  def update
    #@question.user = current_user
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    #без этой проверки можно удалять вопросы другого юзера
    if current_user.author_of?(@question)
      respond_with(@question.destroy)
    else
      redirect_to new_user_session_path
    end
  end

  private

  def flash_interpolation_options
    {resource_name: 'new question', time: @question.created_at, user: current_user.email}
  end

  def build_answer
    @answer = @question.answers.build
  end

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

  end
end
