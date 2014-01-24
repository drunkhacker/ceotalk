class AddTypeToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :type, :string
  end
end
