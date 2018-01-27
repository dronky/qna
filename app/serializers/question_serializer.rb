class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :attachments
  has_many :comments

  def attachments
    object.attachments.map { |a| { 'url' => a.file.url } }
  end

end
