Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'topbikers#index'
  resources :topbikers
  resources :camp1, onry: :show
  resources :camp2, onry: :show
  resources :camp3, onry: :show
  resources :item1, onry: :show
  resources :item2, onry: :show
  resources :item3, onry: :show
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
