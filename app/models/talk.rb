class Talk < Content
  self.table_name = "talks"

  belongs_to :professional
  belongs_to :category
  has_many :comments, :as => :commentable

  validates_presence_of :url
  validates_presence_of :description
  validates_presence_of :professional_id


  def embed_url
    pattern_youtube = /(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?v=([a-zA-Z0-9]+)/i
    r = url.scan pattern_youtube

    unless r.empty?
      vid = r[0][0]
      return "//www.youtube.com/embed/#{vid}"
    end

    pattern_vimeo = /(?:https?:\/\/)?(?:www\.)?vimeo\.com\/([a-zA-Z0-9]+)/i
    r = url.scan pattern_vimeo

    unless r.empty?
      vid = r[0][0]
      return "//player.vimeo.com/video/#{vid}?title=0&amp;byline=0&amp;portrait=0"
    end
  end
end
