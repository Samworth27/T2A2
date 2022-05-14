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
    resources :users
    root to: 'categories#index'
  end

  namespace :trader do
    resources :listings
    root to: 'listings#index'
  end

  scope '/view' do
    get '/categories/root', to: redirect('view/categories')
    get '/categories/:id', to: 'categories#show', as: :category
    get '/categories/:cat_id/:id', to: 'items#show', as: :item
    resources :categories
    resources :items
    resources :listings

    root to: 'categories#index', as: :view
  end

  # resources :scaffolds

  devise_for :users, controllers: { registrations: 'user/registrations' }

  # get '/trader', to: 'static_pages#trader', as: :trader
  get '/moderator', to: 'static_pages#moderator', as: :moderator_root

  root 'static_pages#index'
end
