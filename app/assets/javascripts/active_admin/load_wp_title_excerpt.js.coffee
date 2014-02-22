$ () ->
  if ($("body").hasClass("new") or $("body").hasClass("edit")) and $("body").hasClass("admin_posts")
    # add watcher for url field
    $("#post_url").change () ->
      url = $("#post_url").val()

      #check if it's from wordpress.com
      pattern_ceomba_com = /^(?:https?:\/\/)?blog.ceomba.co.kr/
      captures = pattern_ceomba_com.exec url

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
        # case 5) check 
        else if (captures = archive_pattern.exec(parser.pathname); captures? and captures[1]?)
          id = captures[1]

        setField = (response) ->
          console.log response
          $("#post_title").val response.post.post_title
          $("#post_description").val $("<div/>").html(response.post.post_content).text()
          $("#post_description").trigger "change"

          # find image
          featured_image = response.post.post_thumbnail
          if featured_image? and featured_image != []
            $("#post_thumb_url").val featured_image.thumbnail
            return $("#post_thumb_url").trigger "change"

        if id?
          console.log "get id = #{id}"
          $.getJSON "/posts/wordpress/#{id}", (response) ->
            console.dir response
            setField response
