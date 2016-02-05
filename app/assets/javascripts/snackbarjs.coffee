$(document).ready () ->
  $.each flashMessages, (key, value) ->
    $.snackbar {content: value, style: key, timeout: 2000}

$(document).on 'page:load', () ->
  $.each flashMessages, (key, value) ->
    $.snackbar {content: value, style: key, timeout: 2000}
