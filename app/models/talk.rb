require 'video_embed'
require 'likeable'
class Talk < ActiveRecord::Base

  belongs_to :professional
  belongs_to :category
  has_many :comments, :as => :commentable
  has_many :tags, :as => :taggable
  has_many :categories, :through => :tags

  validates_presence_of :url
  validates_presence_of :description
  validates_presence_of :professional_id

  include ::VideoEmbeddable
  include ::Likeable
  include ::Favorable

  def category_names(separator=" / ")
    categories.map {|c| c.name}.join separator
  end

  def class_name
    "Talk"
  end
end
