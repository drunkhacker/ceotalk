module Likeable
  def Likeable.included(base)
    base.has_many :likes, :as => :likeable
  end

  def like(user)
    created = true
    begin
      Like.create(user_id: user.id, likeable_id: self.id, likeable_type: self.class.name)
    rescue ActiveRecord::RecordNotUnique
      created = false
    end

    self.increment! :like_count if created
    created
  end
end
