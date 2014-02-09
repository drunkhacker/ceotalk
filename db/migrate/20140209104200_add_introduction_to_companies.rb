class AddIntroductionToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :introduction, :text
    remove_column :companies, :web
  end
end
