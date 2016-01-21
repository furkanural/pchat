# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  $('#send').on 'click', ->
    if $('#input-send').val().length
      App.conversation.speak $('#input-send').val(), $('#user').val(), $('#conversation').val()
      $('#input-send').val('')

  $('#input-send').on 'keypress', (event) ->
    if $('#input-send').val().length
      if event.keyCode is 13
        App.conversation.speak $('#input-send').val(), $('#user').val(), $('#conversation').val()
        $('#input-send').val('')
        event.preventDefault()
