class Professional < User
  has_many :talks
  has_many :problems
  has_many :posts

  def contents
    (self.posts + self.talks).sort {|x,y| y.created_at <=> x.created_at}
  end
end
