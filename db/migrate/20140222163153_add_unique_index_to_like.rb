class AddUniqueIndexToLike < ActiveRecord::Migration
  def change
    remove_index :likes, [:user_id, :likeable_id]
    add_index :likes, [:user_id, :likeable_id], unique: true
  end
end
