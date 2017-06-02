Rails.application.routes.draw do

  root 'static_pages#home'
  get '/help',       to: 'static_pages#help',    as: 'help' #help_path
  get '/about',      to: 'static_pages#about',   as: 'about' #about_path
  get '/contact',    to: 'static_pages#contact', as: 'contact' #contact_path
  get '/signup',     to: 'users#new',            as: 'signup' #signup_path
  post '/signup',    to: 'users#create'
  get '/signin',     to: 'sessions#new',         as: 'signin' #signin_path
  post '/signin',    to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy',     as: 'signout' #signout_path
  resources :users
  resources :account_activations, only: [:edit]
  resources :microposts,          only: [:create, :destroy]
end
