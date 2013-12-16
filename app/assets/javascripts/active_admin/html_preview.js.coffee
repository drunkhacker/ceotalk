$ ->
  #grep the html-preview objects and convert it to image
  $(".html-preview").each (indx) ->
    $dom = $ this
    $dom.css "display", "none"
    $dom.on "change", () ->
      $(this).next().html $dom.val()
    $previewdom = $ """<div class="preview"></div>"""
    $previewdom.html $dom.val()
    $dom.after $previewdom
    $dom.parent().addClass "clearfix"
