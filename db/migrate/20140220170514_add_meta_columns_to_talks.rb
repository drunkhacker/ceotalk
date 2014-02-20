class AddMetaColumnsToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :like_count, :integer, :default => 0
    add_column :talks, :comment_count, :integer, :default => 0
  end
end
