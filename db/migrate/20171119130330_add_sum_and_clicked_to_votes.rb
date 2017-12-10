class AddSumAndClickedToVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :sum, :integer, default: 0
    add_column :votes, :clicked, :boolean, default: false
  end
end
