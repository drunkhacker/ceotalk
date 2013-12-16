class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  belongs_to :parent, :class_name => "Comment"
  has_many :comments, :foreign_key => "parent_id"

  validates_presence_of :user_id
  validates_presence_of :content
end
