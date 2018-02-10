class AttachmentableToPolymorphic < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :attachmentable_id, :integer
    add_index :attachments, :attachmentable_id

    add_column :attachments, :attachmentable_type, :string
    add_index :attachments, :attachmentable_type
  end
end
