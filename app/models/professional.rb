class Professional < User
  has_many :talks
  has_many :problems
  has_many :posts

  has_many :comments, :as => :commentable

  def contents
    (self.posts + self.talks).sort {|x,y| y.created_at <=> x.created_at}
  end

  def category_name
    if self.category then self.category.name else nil end
  end

  def self.find_by_keyword(term)
    term = term.split(" ").map {|s| "#{s}*"}.join(" ")
    Professional.where("MATCH(name, career, introduction) AGAINST (? IN BOOLEAN MODE)", term)
  end
end
