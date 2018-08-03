Rails.application.routes.draw do
  devise_for :users
  devise_for :models
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
