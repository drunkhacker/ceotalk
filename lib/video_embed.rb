module VideoEmbeddable
  def embed_url(field=:url)
    pattern_youtube = /(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?v=([a-zA-Z0-9_-]+)/i
    r = self.send(field).scan pattern_youtube

    unless r.empty?
      vid = r[0][0]
      return "//www.youtube.com/embed/#{vid}"
    end

    pattern_vimeo = /(?:https?:\/\/)?(?:www\.)?vimeo\.com\/([a-zA-Z0-9_-]+)/i
    r = self.send(field).scan pattern_vimeo

    unless r.empty?
      vid = r[0][0]
      return "//player.vimeo.com/video/#{vid}?title=0&amp;byline=0&amp;portrait=0"
    end
  end
end
