Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'topbikers#index'
  resources :posts do
    resources :comments, only: :create
  end
  resources :consultations do
    resources :consultations_comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
end
