Rails.application.routes.draw do
  root to: 'conversations#new'

  resources :conversations, only: [:create, :new, :show]
  # Serve websocket cable requests in-process
   mount ActionCable.server => '/cable'
end
