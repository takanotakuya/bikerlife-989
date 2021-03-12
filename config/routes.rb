Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'topbikers#index'
  resources :topbikers
  resources :camps_ones, only: :index
  resources :camps_twos, only: :index
  resources :camps_threes, only: :index
  resources :items_ones, only: :index
  resources :items_twos, only: :index
  resources :items_threes, only: :index
  resources :posts do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :consultations do
    resources :consultations_comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show, :edit, :update]
end
