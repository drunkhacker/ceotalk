class RemoveCategoryIdFromTalks < ActiveRecord::Migration
  def change
    remove_column :talks, :category_id
  end
end
