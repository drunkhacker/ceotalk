class CreateFeaturedExperts < ActiveRecord::Migration
  def change
    create_table :featured_experts do |t|
      t.integer :professional_id, null: false
      t.string :featured_photo, null: false
      t.text :excerpt, null: false

      t.timestamps
    end
  end
end
