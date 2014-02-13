class AddThumbnailToOpenQuestions < ActiveRecord::Migration
  def change
    add_column :open_questions, :thumbnail, :string
  end
end
