Rails.application.routes.draw do
#   get 'item/index'
#  root 'users#index'

  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index, :new]

end