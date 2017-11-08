class Attachment < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :attachmentable, polymorphic: true, optional: true
end
