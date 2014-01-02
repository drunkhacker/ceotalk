class ChangeCategoryToModel < ActiveRecord::Migration
  def change
    rename_column :users, :category, :expert_category_id
    change_column :users, :expert_category_id, :integer
  end
end
