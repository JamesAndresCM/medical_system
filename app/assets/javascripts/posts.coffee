# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ()->
  jQuery(".best_in_place").best_in_place()


$(document).ready ->
  $('input[id^="btn-comments_"]').on 'click', ->
    id_show = @id.match(/\d+/)
    $('.comments_div' + id_show).toggle()
    return
  return
