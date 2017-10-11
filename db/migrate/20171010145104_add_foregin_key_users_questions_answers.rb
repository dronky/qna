class AddForeginKeyUsersQuestionsAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :user_id, :integer
    add_column :questions, :user_id, :integer
  end
end
