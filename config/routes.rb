Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :create] do
    resources :favorites, only: [:create, :destroy]
    resources :terms, only: [:new, :create]
  end

  resources :chat_rooms, only: [:new, :create, :show, :index, :destroy] do
    collection do
      post :help
    end
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  match "/chat_rooms" => "chat_rooms#create", :as => "create_chat", via: [:get, :post]

  mount ActionCable.server => '/cable'

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
