class AddAfterCommentsToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :after_comment_1, :text
    add_column :problems, :after_comment_2, :text
  end
end
