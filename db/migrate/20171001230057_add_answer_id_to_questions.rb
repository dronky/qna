class AddAnswerIdToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :answer_id, :integer
  end
end
