# frozen_string_literal: true

Rails.application.routes.draw do
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

  root 'static_pages#index'
end
