class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id, :null => false
      t.integer :expert_category_id, :null => false
      t.timestamps
    end
  end
end
