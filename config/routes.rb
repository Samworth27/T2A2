Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/home', to: 'static_pages#index', as: :home
  get '/trader', to: 'static_pages#trader', as: :trader
  get '/moderator', to: 'static_pages#moderator', as: :moderator
  get '/admin', to: 'static_pages#admin', as: :admin
  
  root "static_pages#index"
end
