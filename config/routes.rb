Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root 'home#top'
  get 'about', to: "home#about"
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get '/users/:id/user_posts', to: 'users#user_posts', as: :user_posts

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :users do
    get :favorites, on: :collection
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
    member do
      get :favorites
    end
  end

  resources :posts , expect: [:index] do
    resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
