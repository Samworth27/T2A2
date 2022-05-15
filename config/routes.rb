# frozen_string_literal: true

Rails.application.routes.draw do

  
  namespace :admin do
    resources :categories
    resources :listings
    resources :active_storage_blobs
    resources :items
    resources :active_storage_attachments
    resources :scaffolds
    resources :quantity_types
    resources :roles
    root to: 'categories#index'
  end

  namespace :trader do
    resources :listings
    root to: 'listings#index'
  end

  get '/profile', to: 'profiles#show', as: :own_profile
  get '/profile/edit', to: 'profiles#edit', as: :edit_own_profile
  put '/profile/edit', to: 'profiles#update'
  patch '/profile/edit', to: 'profiles#update'
  resources :profiles

  # resolve("Profile") { [:profile] }

  scope '/view' do
    get '/categories/root', to: redirect('view/categories')
    get '/categories/:id', to: 'categories#show', as: :category
    get '/categories/:cat_id/:id', to: 'items#show', as: :item
    resources :categories
    resources :items
    resources :listings
    root to: 'categories#index', as: :view
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


  get '/moderator', to: 'static_pages#moderator', as: :moderator_root

  root 'static_pages#index'
end
