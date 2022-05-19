# frozen_string_literal: true

Rails.application.routes.draw do
  # Admin Dashboard
  namespace :admin do
    resources :categories
    resources :listings
    resources :users
    resources :profiles
    resources :roles
    resources :measurements
    root to: 'categories#index'
  end

  # Trader Dashboard
  namespace :trader do
    resources :listings
    root to: 'listings#index'
  end

  namespace :messages do
    post '/new', to: 'messages#create', as: :new
    post '/reply', to: 'messages#reply', as: :reply
    get 'conversation/:id', to: 'conversations#show', as: :conversation
    root to: 'conversations#index'
  end

  scope :profile do
    get 'edit', to: 'profiles#edit', as: :manage_profile
    put 'edit', to: 'profiles#update'
    patch 'edit', to: 'profiles#update'
    get '/:id', to: 'profiles#show', as: :profile
    get '', to: 'profiles#show', as: :own_profile
  end

  get 'users', to: 'profiles#edit'

  scope '/view' do
    get '/categories/root', to: redirect('view/categories')
    get '/categories/:id', to: 'categories#show', as: :category
    get '/categories/:cat_id/:id', to: 'items#show', as: :item
    resources :categories
    resources :listings
    root to: 'categories#index', as: :view
    get '/profile/:id', to: 'profile#show'
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # get '/moderator', to: 'static_pages#moderator', as: :moderator_root

  get '/faq', to: 'static_pages#faq', as: :faq
  get '/about', to: 'static_pages#about', as: :about

  root 'static_pages#index'
end
