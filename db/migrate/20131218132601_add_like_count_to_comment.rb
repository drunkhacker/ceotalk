class AddLikeCountToComment < ActiveRecord::Migration
  def change
    add_column :comments, :like_count, :integer, default: 0, null: false
  end
end
