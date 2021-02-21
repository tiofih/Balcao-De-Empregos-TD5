Rails.application.routes.draw do
  root 'jobs#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :companies, only: [:show, :new, :create]
  resources :jobs#, only: [:index, :show, :new, :create]
  get 'search_job', to: 'jobs#search'
end
