class AddFeaturedAndOrderToContents < ActiveRecord::Migration
  def change
    add_column :talks, :order, :integer, default: 0
    add_column :posts, :order, :integer, default: 0
    add_column :users, :featured, :boolean, default: false
    add_column :companies, :featured, :boolean, default: false
  end
end
