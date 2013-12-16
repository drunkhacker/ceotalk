class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.string :url, null: false # presentation video url
      t.text :description
      t.timestamps
    end
  end
end
