module Favorable
  def Favorable.included(base)
    base.has_many :favorites, :as => :favorable
  end

  def favorite(user)
    created = true
    begin
      Favorite.create(user_id: user.id, favorable_id: self.id, favorable_type: self.class.name)
    rescue ActiveRecord::RecordNotUnique
      created = false
    end
    created
  end
end
