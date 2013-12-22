class AddDatesToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :phase, :integer, default: 0, null: false
    add_column :problems, :phase1_deadline, :datetime
    add_column :problems, :phase2_deadline, :datetime
  end
end
