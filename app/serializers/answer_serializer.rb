class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :attachments

  has_many :comments

  def attachments
    object.attachments.map { |a| { 'url' => a.file.url } }
  end
end
