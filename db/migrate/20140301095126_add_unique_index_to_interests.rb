class AddUniqueIndexToInterests < ActiveRecord::Migration
  def change
    add_index :interests, [:user_id, :category_id], :unique => true
    remove_column :interests, :id
  end
end
