class OpenQuestion < ActiveRecord::Base
  has_many :comments, :as => :commentable

  validates_presence_of :title
  validates_presence_of :content
end
