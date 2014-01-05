class Post < Content
  self.table_name = "posts"

  belongs_to :professional
  belongs_to :category
  has_many :comments, :as => :commentable

  validates_presence_of :url
  validates_presence_of :professional_id

end
