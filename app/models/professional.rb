class Professional < User
  has_many :talks
  has_many :problems
  has_many :posts

  def contents
    (self.posts + self.talks).sort {|x,y| y.created_at <=> x.created_at}
  end

  def category_name
    if self.expert_category then self.expert_category.name else nil end
  end
end
