class AddTitleToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :title, :string
  end
end
