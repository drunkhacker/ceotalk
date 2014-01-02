class AddVoteCountToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :vote_count, :integer, null: false, default: 0
  end
end
