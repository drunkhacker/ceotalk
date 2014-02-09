class AddMoreColumnsToExperts < ActiveRecord::Migration
  def change
    add_column :users, :tagline, :string
    add_column :users, :introduction, :text
    add_column :users, :career, :string
    add_column :users, :contact, :string
  end
end
