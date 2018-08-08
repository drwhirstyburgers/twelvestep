Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show]

  resources :chat_rooms, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
