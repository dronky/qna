ThinkingSphinx::Index.define :comment, with: :active_record do
  # fields
  indexes body

  # attributes (for sort, group)
  has commentable_id, created_at, updated_at
end