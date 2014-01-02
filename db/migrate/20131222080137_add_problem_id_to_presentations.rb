class AddProblemIdToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :problem_id, :integer, null: false
  end
end
