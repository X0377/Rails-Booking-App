Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  root to: 'rooms#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :rooms do
    collection do
      get :search
    end
  end
end