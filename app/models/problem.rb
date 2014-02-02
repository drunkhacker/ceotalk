require 'video_embed'
class Problem < ActiveRecord::Base
  PHASE_PRE = 0
  PHASE_FINAL = 1
  PHASE_CLOSE = 2
  PHASE_TO_WORD = {PHASE_PRE => "예선", PHASE_FINAL => "결선", PHASE_CLOSE => "완료"}
  belongs_to :professional
  has_many :comments, :as => :commentable
  has_many :presentations

  validates_presence_of :url
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :professional_id

  include ::VideoEmbeddable
end
