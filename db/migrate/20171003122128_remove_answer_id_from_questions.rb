class RemoveAnswerIdFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :answer_id
  end
end
