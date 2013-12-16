class AddAttrsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :null => false
    add_column :users, :type, :string
  end
end
