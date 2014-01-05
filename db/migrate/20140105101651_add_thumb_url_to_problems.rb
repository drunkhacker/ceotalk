class AddThumbUrlToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :thumb_url, :string
  end
end
