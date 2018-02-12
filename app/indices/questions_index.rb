ThinkingSphinx::Index.define :question, with: :active_record do
  # fields
  indexes title, sortable: true
  indexes body
  # alias -> as
  indexes user.email, as: :author, sortable: true

  # attributes (for sort, group)
  has user_id, created_at, updated_at
end