# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  resources :users, except: %i[new]
  resources :posts
  root 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'help', to: "static_pages#help"
  get 'about', to: "static_pages#about"
  get 'contact', to: "static_pages#contact"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
