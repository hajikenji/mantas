Rails.application.routes.draw do
  root 'tasks#index'
  resources :labels
  resources :users
  resources :tasks
  resources :session, only: %i[new create destroy]
  namespace :admin do
    resources :users
  end
end
