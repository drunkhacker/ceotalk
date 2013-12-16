class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :url, null: false #video url. youtube? vimeo?
      t.text :description
      t.integer :professional_id, null: false
      t.integer :view_count, null: false, default: 0
      t.timestamps
    end
  end
end
