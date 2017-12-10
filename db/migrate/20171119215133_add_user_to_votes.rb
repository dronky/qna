class AddUserToVotes < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :votes, :user, index: true
  end
end
