class QuestionCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title
  has_many :answers, serializer: AnswerSerializer

  def index
    {object.id => {isssd: object.id}}
  end
end
