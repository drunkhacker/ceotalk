require 'likeable'
class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  #belongs_to :parent, :class_name => "Comment"
  has_many :comments, :as => :commentable

  validates_presence_of :user_id
  validates_presence_of :content

  include ::Likeable

  has_many :likers, :through => :likes, :class_name => "User"
end
