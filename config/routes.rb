Rails.application.routes.draw do
  devise_for :users
  root to: 'topbikers#index'
  resources :posts do
    resources :comments, only: :create
  end
  resources :consultations
    resources :consultations_comments, only: :create
end
