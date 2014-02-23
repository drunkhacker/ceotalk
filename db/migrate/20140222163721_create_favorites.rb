class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites, id: false do |t|
      t.integer :favorable_id, null: false
      t.string :favorable_type, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :favorites, [:user_id, :favorable_id, :favorable_type], :unique => true

    #rebuild like index
    remove_index :likes, [:user_id, :likeable_id]
    add_index :likes, [:user_id, :likeable_id, :likeable_type], :unique => true
  end
end
