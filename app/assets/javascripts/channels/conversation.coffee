App.conversation = App.cable.subscriptions.create "ConversationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['conversation'].toString() is($('#conversation').val().toString())
      $('#messages').prepend(data['message'])

  speak: (message, id, conversation) ->
    @perform 'speak', message: message, user: id, conversation: conversation
