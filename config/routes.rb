Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  root to: 'rooms#index'
  devise_for :users
  resources :rooms
  resources :users, only: [:show, :edit, :update]
end