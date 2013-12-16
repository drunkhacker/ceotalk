class Presentation < ActiveRecord::Base
  has_many :votes

  validates_presence_of :url
end
