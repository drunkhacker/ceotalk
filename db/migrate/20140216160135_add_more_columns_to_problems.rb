class AddMoreColumnsToProblems < ActiveRecord::Migration
  def change
    rename_column :problems, :url, :url_question
    add_column :problems, :url_final, :string
    add_column :problems, :sketch_photo, :string
  end
end
