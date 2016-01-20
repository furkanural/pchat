class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'some_channel', message: render_message(message), conversation: message.conversation.id
  end

  private
  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
  end
end
