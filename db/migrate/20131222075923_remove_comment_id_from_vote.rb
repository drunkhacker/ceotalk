class RemoveCommentIdFromVote < ActiveRecord::Migration
  def change
    remove_column :votes, :comment_id
  end
end
