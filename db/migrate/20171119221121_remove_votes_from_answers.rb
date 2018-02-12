class RemoveVotesFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :votes
  end
end
