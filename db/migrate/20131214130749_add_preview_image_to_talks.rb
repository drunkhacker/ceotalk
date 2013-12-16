class AddPreviewImageToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :thumb_url, :string, null: false
  end
end
