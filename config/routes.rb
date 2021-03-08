Rails.application.routes.draw do
  devise_for :users
  root to: 'topbikers#index'
  resources :posts, only: [:index, :new, :create, :show, :edit]
end
