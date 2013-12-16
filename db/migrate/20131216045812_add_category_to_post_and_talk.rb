class AddCategoryToPostAndTalk < ActiveRecord::Migration
  def change
    add_column :posts, :category_id, :integer, :null => false
    add_column :talks, :category_id, :integer, :null => false
  end
end
