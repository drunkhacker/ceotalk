class AddTypeAndPickedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :type, :string
    add_column :comments, :picked, :boolean
  end
end
