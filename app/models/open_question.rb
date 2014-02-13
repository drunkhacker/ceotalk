class OpenQuestion < ActiveRecord::Base
  has_many :comments, :as => :commentable
  belongs_to :professional

  validates_presence_of :title
  validates_presence_of :content

  has_many :tags, :as => :taggable
  has_many :categories, :through => :tags

  mount_uploader :thumbnail, QuestionThumbnailUploader

  def category
    self.categories.map {|c| c.name}.join(" / ")
  end

end
