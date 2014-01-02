class AddCategoryToExperts < ActiveRecord::Migration
  def change
    add_column :users, :position, :string #직위
    add_column :users, :category, :string #업무
  end
end
