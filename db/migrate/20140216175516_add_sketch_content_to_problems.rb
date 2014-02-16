class AddSketchContentToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :sketch_content, :text
  end
end
