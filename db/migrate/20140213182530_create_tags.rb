class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :category_id, :null => false
      t.integer :taggable_id, :null => false
      t.string :taggable_type, :null => false
      t.timestamps
    end
  end
end
