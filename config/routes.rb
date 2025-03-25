Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update], constraints: { id: /\d+/ }
  root to: 'rooms#index'
  resources :rooms do
    collection do
      get :search
    end
    resources :reservations, only: [:new, :create, :index, :show, :destroy] do
      collection do
        post :confirm
      end
    end
  end
end