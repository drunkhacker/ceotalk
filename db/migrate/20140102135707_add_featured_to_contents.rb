class AddFeaturedToContents < ActiveRecord::Migration
  def change
    add_column :posts, :featured, :boolean, default: false
    add_column :talks, :featured, :boolean, default: false
  end
end
