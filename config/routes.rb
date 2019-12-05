# frozen_string_literal: true

Rails.application.routes.draw do

  root 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  post 'users', to: 'users#create'
  get 'users/:id/second_factor', to: 'users#second_factor', as: 'second_factor'
  post 'users/:id/second_factor', to: 'users#second_factor_setup', as: 'second_factor_setup'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

end
