class CreateOpenQuestions < ActiveRecord::Migration
  def change
    create_table :open_questions do |t|
      t.string :title
      t.text :content
      t.integer :view_count, null: false, default: 0
      t.timestamps
    end
  end
end
