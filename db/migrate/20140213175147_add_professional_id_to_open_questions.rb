class AddProfessionalIdToOpenQuestions < ActiveRecord::Migration
  def change
    add_column :open_questions, :professional_id, :integer
  end
end
