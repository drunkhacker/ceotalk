class AddDescriptionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :short_description, :string
    add_column :users, :description, :text
  end
end
