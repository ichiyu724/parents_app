Rails.application.routes.draw do
  get 'users/account'
  devise_for :users
  root 'home#top'
  
  get 'about', to: "home#about"
  resources :posts
  get '/users/account', to: 'users#account', as: :account
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
