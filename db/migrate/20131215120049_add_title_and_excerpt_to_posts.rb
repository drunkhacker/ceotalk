class AddTitleAndExcerptToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string, :null => false
    add_column :posts, :excerpt, :string
    add_column :posts, :thumb_url, :string
  end
end
