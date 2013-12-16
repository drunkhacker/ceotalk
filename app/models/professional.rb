class Professional < User
  has_many :talks
  has_many :problems
  has_many :posts
end
