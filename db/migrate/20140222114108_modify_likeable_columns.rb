class ModifyLikeableColumns < ActiveRecord::Migration
  def change
    #likes table change
    remove_index :likes, [:user_id, :comment_id]
    rename_column :likes, :comment_id, :likeable_id
    add_column :likes, :likeable_type, :string, null: false
    add_index :likes, [:user_id, :likeable_id]

    # add like_count
    add_column :companies, :like_count, :integer, default: 0, null: false
    add_column :problems, :like_count, :integer, default: 0, null: false
    add_column :users, :like_count, :integer, default: 0, null: false
  end
end
