Rails.application.routes.draw do
  # get 'items/index'
  root to: 'items#index'
  devise_for :users
  resources :items, only: [:new, :create]
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions'   
  # } 
  # resources :user
end
