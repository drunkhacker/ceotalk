$ ->
  $(".featured-checkbox").change () ->
    checked = $(this).is(":checked")
    id = $(this).attr("id").split("_")[1]

    # update 
    collection = if $(this).attr("talk_type") == "video" then "videos" else "posts"
    $.post "/admin/#{collection}/#{id}/toggle_featured", {featured: checked ? 1 : 0}, () ->
      #nop

