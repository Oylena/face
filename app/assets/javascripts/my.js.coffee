jQuery ->
  $('.btn-upload').change ->
    $('form').submit()

  $(".me-photo-container").click ->
    $(this).toggleClass('selected')
    $(".you-photo-container").removeClass('selected')

  $(".you-photo-container").click ->
    $(this).toggleClass('selected')
    $(".me-photo-container").removeClass('selected')

  $(".image-thumb").click ->
    return if $(".photo-container.selected").length == 0
    $(".photo-container.selected img").attr('src', $(this).attr('src'))

  $("#reset").click ->
    document.location = location.protocol + '//' + location.host + location.pathname

  $("#recognize").click ->
    base_location = location.protocol + '//' + location.host + location.pathname
    image_1 = $(".me-photo-container img").attr('src').split('/')[1]
    image_2 = $(".you-photo-container img").attr('src').split('/')[1]
    new_location = "{base_location}?a={image_1}&b={image_2}"

    document.location = new_location.
      replace("{base_location}", base_location).
      replace("{image_1}", image_1).
      replace("{image_2}", image_2)

    


