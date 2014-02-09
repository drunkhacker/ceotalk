class AddTaglineToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :tagline, :string
  end
end
