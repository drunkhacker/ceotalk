module Likeable
  def Likeable.included(base)
    base.has_many :likes, :as => :likeable
  end

  def class_name
    self.class.name
  end

  def like(user)
    created = true
    begin
      Like.create(user_id: user.id, likeable_id: self.id, likeable_type: self.class_name)
      self.increment! :like_count
    rescue ActiveRecord::RecordNotUnique
      Like.delete_all(user_id: user.id, likeable_id: self.id, likeable_type: self.class_name)
      self.decrement! :like_count
      created = false
    end

    created
  end
end
