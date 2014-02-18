class ChangeExpertCategoryToCategory < ActiveRecord::Migration
  def change
    rename_column :interests, :expert_category_id, :category_id
  end
end
