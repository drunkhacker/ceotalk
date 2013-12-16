class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :url, null: false #video url
      t.text :content, null: false
      t.integer :professional_id, null: false
      t.timestamps
    end
  end
end
