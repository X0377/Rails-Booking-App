Rails.application.routes.draw do
  root to: 'rooms#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :rooms do
    collection do
      get :search
    end
    resources :reservations, only: [:new, :create, :index, :show]
  end
end