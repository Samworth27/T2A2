# frozen_string_literal: true

Rails.application.routes.draw do
  get 'listing/index'
  get 'listing/show'
  get 'listing/edit'
  get 'listing/create'
  resources :scaffolds

  get 'categories/index'
  get 'categories/show'

  devise_for :users, controllers: { registrations: 'user/registrations' }
  # devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/', to: 'categories#index', as: :home
  get '/categories/root', to: redirect('/')
  get '/categories/:id', to: 'categories#show', as: :category

  get '/trader', to: 'static_pages#trader', as: :trader
  get '/moderator', to: 'static_pages#moderator', as: :moderator
  get '/admin', to: 'static_pages#admin', as: :admin

  get '/admin/edit/item/:id', to: 'items#edit', as: :edit_item
  patch '/admin/edit/item/:id', to: 'items#update'
  get '/categories/:cat_id/:id', to: 'items#show', as: :item

  root 'static_pages#index'
end
