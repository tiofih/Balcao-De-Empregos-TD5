Rails.application.routes.draw do
  root 'jobs#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :companies
  resources :jobs do
    post 'apply', on: :member
  end
  get 'search_job', to: 'jobs#search'
  resources :visitors
end
