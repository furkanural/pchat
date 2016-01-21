Rails.application.routes.draw do
  root to: 'conversations#new'

  resources :conversations, only: [:create, :new, :show]
  resources :users, only: [:show, :update]
  # Serve websocket cable requests in-process
   mount ActionCable.server => '/cable'
end
