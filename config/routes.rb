Rails.application.routes.draw do
  devise_for :users

  resources :orders
  resources :services
  resources :specialists
  resources :categories
  
  root to: "orders#index"
  
end
