class RemoveCategoryIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :expert_category_id
  end
end
