$ ->
  #grep the image-preview objects and convert it to image
  $(".image-preview").each (indx) ->
    $dom = $ this
    $dom.attr "type", "hidden"
    $dom.on "change", () ->
      console.log "change called, val = #{$dom.val()}"
      $(this).next().attr "src", $dom.val()
    $img = $ """<img src="" class="thumb-preview">"""
    $img.attr "src", $dom.val()
    $dom.after $img
