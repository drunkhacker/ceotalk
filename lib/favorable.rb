module Favorable
  def Favorable.included(base)
    base.has_many :favorites, :as => :favorable
  end

  def class_name
    self.class.name
  end

  def favorite(user)
    created = true
    begin
      Favorite.create(user_id: user.id, favorable_id: self.id, favorable_type: self.class_name)
    rescue ActiveRecord::RecordNotUnique
      #toggle
      Favorite.delete_all(user_id: user.id, favorable_id: self.id, favorable_type: self.class_name)
      created = false
    end
    created
  end
end
