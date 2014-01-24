$ () ->
  if ($("body").hasClass("new") or $("body").hasClass("edit")) and $("body").hasClass("admin_posts")
    # add watcher for url field
    $("#post_url").change () ->
      url = $("#post_url").val()

      #check if it's from wordpress.com
      pattern_wp_com = /^(?:https?:\/\/)?(?:www\.)?(?:[\w\d]+\.)wordpress.com/
      captures = pattern_wp_com.exec url

      if captures?
        console.log "got captures"
        parser = document.createElement "a"
        parser.href = url

        #1. http://blog.drunkhacker.me/?p=123
        #2. http://blog.drunkhacker.me/index.php/2013/12/15/sample-post/
        #3. http://blog.drunkhacker.me/index.php/2013/12/sample-post/
        #4. http://blog.drunkhacker.me/index.php/sample-post/
        #5. http://blog.drunkhacker.me/index.php/archives/123

        id = null
        slug = null

        post_id_pattern = /p=([0-9]+)/
        slug_pattern = /(?:[0-9]{4}\/)?(?:[0-9]+\/)?(?:[0-9]+\/)?([가-힣0-9a-z-]+)/
        archive_pattern = /archives\/([0-9]+)/

        # case 1) check 
        captures = null
        if (captures = post_id_pattern.exec(parser.search); captures? and captures[1]?)
          id = captures[1]
        # case 2,3,4) check 
        else if (captures = slug_pattern.exec(parser.pathname); captures? and captures[1]?)
          slug = captures[1]
        # case 5) check 
        else if (captures = archive_pattern.exec(parser.pathname); captures? and captures[1]?)
          id = captures[1]

        setField = (response) ->
          $("#post_title").val $("<div/>").html(response["title"]).text()
          $("#post_description").val response["excerpt"]
          $("#post_description").trigger "change"

          # find image
          featured_image = response["featured_image"]
          if featured_image? and featured_image.length > 0
            $("#post_thumb_url").val featured_image
            return $("#post_thumb_url").trigger "change"
          else 
            # get first image attachment
            attachments = response["attachments"]
            if attachments?
              for id, obj of attachments
                console.log "id = #{id}"
                if obj.mime_type.substring(0,5) == "image"
                  $("#post_thumb_url").val obj["URL"]
                  return $("#post_thumb_url").trigger "change"



        if slug?
          console.log "get slug = #{slug}"
          $.getJSON "https://public-api.wordpress.com/rest/v1/sites/#{parser.host}/posts/slug:#{slug}?callback=?", (response) ->
            setField response

        else if id?
          console.log "get id = #{id}"
          $.getJSON "https://public-api.wordpress.com/rest/v1/sites/#{parser.host}/posts/#{id}?callback=?", (response) ->
            setField response
