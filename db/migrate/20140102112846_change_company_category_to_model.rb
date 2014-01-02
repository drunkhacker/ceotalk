class ChangeCompanyCategoryToModel < ActiveRecord::Migration
  def change
    rename_column :companies, :category, :company_category_id
    change_column :companies, :company_category_id, :integer
  end
end
