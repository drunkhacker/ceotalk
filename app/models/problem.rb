require 'video_embed'
class Problem < ActiveRecord::Base
  PHASE_PRE = 0
  PHASE_FINAL = 1
  PHASE_CLOSE = 2
  PHASE_TO_WORD = {PHASE_PRE => "예선", PHASE_FINAL => "결선", PHASE_CLOSE => "완료"}
  belongs_to :professional
  has_many :comments, :as => :commentable
  has_many :presentations

  has_many :tags, :as => :taggable
  has_many :categories, :through => :tags

  validates_presence_of :url_question
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :professional_id

  include ::VideoEmbeddable

  # carrierwave
  mount_uploader :sketch_photo, FinalSketchUploader

  def category
    self.categories.map {|c| c.name}.join(" / ")
  end
end
