class AddTitleToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :title, :string, null: false
  end
end
