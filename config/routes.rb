Rails.application.routes.draw do
#   get 'item/index'

  devise_for :users
  root to: 'items#index'

  resources :items

end