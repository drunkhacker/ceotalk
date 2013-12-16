class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url, null: false #wordpress post url
      t.integer :professional_id, null: false
      t.integer :view_count, null: false, default: 0
      t.timestamps
    end
  end
end
