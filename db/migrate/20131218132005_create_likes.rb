class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes, :id => false do |t|
      t.integer :user_id, null: false
      t.integer :comment_id, null: false

      t.timestamps
    end

    add_index :likes, [:user_id, :comment_id], :unique => true
  end
end
