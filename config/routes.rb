Rails.application.routes.draw do

  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  post   'login', to: 'sessions#create'
  get 'users/:id/second_factor', to: 'users#second_factor', as: 'second_factor'
  post 'users/:id/second_factor', to: 'users#second_factor_setup', as: 'second_factor_setup'

end
