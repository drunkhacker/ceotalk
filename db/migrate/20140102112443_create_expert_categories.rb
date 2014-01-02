class CreateExpertCategories < ActiveRecord::Migration
  def change
    create_table :expert_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
