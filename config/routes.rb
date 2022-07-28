Rails.application.routes.draw do
  get 'users/account'
  devise_for :users
  root 'home#top'
  
  get 'about', to: "home#about"
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/users/account', to: 'users#account', as: :account
  get '/users/my_post', to: 'users#my_post', as: :my_post


  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :users do #only: [:show, :edit, :update] do
    get :favorites, on: :collection
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
    member do
      get :favorites
    end
  end

  #resources :users do
   # member do
    #  get :favorites
    #end
  #end

  resources :posts , expect: [:index] do
    resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
