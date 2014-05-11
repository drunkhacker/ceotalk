class OpenQuestion < ActiveRecord::Base
  has_many :comments, :as => :commentable
  belongs_to :professional

  validates_presence_of :title
  validates_presence_of :content

  has_many :tags, :as => :taggable
  has_many :categories, :through => :tags

  mount_uploader :thumbnail, QuestionThumbnailUploader

  include ::Likeable
  include ::Favorable

  def category_names(separator=" / ")
    categories.map {|c| c.name}.join separator
  end

  def thumb_url
    self.thumbnail.url
  end
end
