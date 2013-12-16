class Problem < ActiveRecord::Base
  belongs_to :professional
  has_many :comments, :as => :commentable
  has_many :presentations

  validates_presence_of :url
  validates_presence_of :content
  validates_presence_of :professional_id
end
