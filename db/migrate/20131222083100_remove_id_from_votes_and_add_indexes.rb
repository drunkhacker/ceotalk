class RemoveIdFromVotesAndAddIndexes < ActiveRecord::Migration
  def change
    remove_column :votes, :id
    add_index :votes, [:user_id, :presentation_id], :unique => true
  end
end
