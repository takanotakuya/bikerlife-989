Rails.application.routes.draw do
  devise_for :users
  root to: 'topbikers#index'
  resources :posts do
    resources :comments, only: :create
  end
  resources :consultations, only: [:index, :new, :create, :edit, :update, :show]
end
