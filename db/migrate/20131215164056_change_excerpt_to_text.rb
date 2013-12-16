class ChangeExcerptToText < ActiveRecord::Migration
  def change
    change_column :posts, :excerpt, :text
  end
end
