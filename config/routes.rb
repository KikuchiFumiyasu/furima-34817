Rails.application.routes.draw do
#   get 'item/index'
#  root 'users#index'

  devise_for :users
  root to: 'items#index'

end