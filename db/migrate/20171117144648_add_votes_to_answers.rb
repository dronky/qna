class AddVotesToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :votes, :integer, default: 0
  end
end
