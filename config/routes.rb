Rails.application.routes.draw do
  # get 'items/index'
  root to: 'items#index'
  devise_for :users
  # devise_for :users, :controllers => {
  #   :registrations => 'users/registrations',
  #   :sessions => 'users/sessions'   
  # } 
  # resources :user
end
