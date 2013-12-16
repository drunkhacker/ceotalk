class Post < ActiveRecord::Base
  belongs_to :professional
  belongs_to :category
  has_many :comments, :as => :commentable

  validates_presence_of :url
  validates_presence_of :professional_id
end
