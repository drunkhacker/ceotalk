$ () ->
  if ($("body").hasClass("new") or $("body").hasClass("edit")) and $("body").hasClass("admin_talks")
    # add watcher for url field
    $("#talk_url").change () ->
      url = $("#talk_url").val()
      console.log "url = #{url}"

      # check this is youtube url
      pattern_youtube = /(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?v=([a-zA-Z0-9]+)/i
      captures = pattern_youtube.exec url

      if captures? and captures[1]?
        vid = captures[1]
        console.log "vid = #{vid}"

        $.getJSON "http://gdata.youtube.com/feeds/api/videos/#{vid}?v=2&alt=jsonc", (data) ->
          data = data.data

          $("#talk_title").val data.title

          $("#talk_description").val data.description

          # update thumbnail img
          $dom = $ "#talk_thumb_url"
          console.log "about to set val"
          $dom.val data.thumbnail.hqDefault
          $dom.trigger "change"


      # check this is vimeo url
      pattern_vimeo = /(?:https?:\/\/)?(?:www\.)?vimeo\.com\/([a-zA-Z0-9]+)/i
      captures = pattern_vimeo.exec url

      if captures? and captures[1]?
        vid = captures[1]
        console.log "vimeo vid = #{vid}"
        $.getJSON "http://vimeo.com/api/v2/video/#{vid}.json", (data) ->

          if data? and data[0]?
            data = data[0]

            $("#talk_description").val data.description
            $("#talk_title").val data.title

            $dom = $ "#talk_thumb_url"
            $dom.val data.thumbnail_large
            return $dom.trigger "change"



