class AddLikeCountToOpenQuestions < ActiveRecord::Migration
  def change
    add_column :open_questions, :like_count, :integer, :default => 0
  end
end
