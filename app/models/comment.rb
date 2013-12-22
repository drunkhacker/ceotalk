class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :parent, :class_name => "Comment"
  has_many :comments, :foreign_key => "parent_id"
  has_many :likes
  has_many :likers, :through => :likes, :class_name => "User"

  validates_presence_of :user_id
  validates_presence_of :content

  def like(user)
    created = true
    begin
      Like.create(user_id: user.id, comment_id: self.id)
    rescue ActiveRecord::RecordNotUnique
      created = false
    end

    self.increment! :like_count if created
  end
end
