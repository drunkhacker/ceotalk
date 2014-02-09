class AddColumnsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :email, :string
    add_column :companies, :web, :string
    add_column :companies, :address, :string
  end
end
