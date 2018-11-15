Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :create] do
    resources :favorites, only: [:create, :destroy]
  end

  resources :chat_rooms, only: [:new, :create, :show, :index, :destroy]

  match "/chat_rooms" => "chat_rooms#create", :as => "create_chat", via: [:get, :post]

  mount ActionCable.server => '/cable'

  mount FinePrint::Engine => "/fine_print"

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
