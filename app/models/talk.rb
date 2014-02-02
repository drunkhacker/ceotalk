require 'video_embed'
class Talk < ActiveRecord::Base

  belongs_to :professional
  belongs_to :category
  has_many :comments, :as => :commentable

  validates_presence_of :url
  validates_presence_of :description
  validates_presence_of :professional_id

  include ::VideoEmbeddable
end
