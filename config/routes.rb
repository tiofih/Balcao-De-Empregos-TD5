Rails.application.routes.draw do
  root 'jobs#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :companies, only: [:show, :new, :create]
  resources :jobs, only: [:show, :new, :create, :update, :edit] do
    post 'apply', on: :member
  end
  get 'search_job', to: 'jobs#search'
  get 'search_job_application', to: 'job_applications#search'
  resources :job_applications, only: [:index, :show] do
    member do
      post 'accept'
      post 'deny'
      post 'visitor_accept'
      post 'visitor_deny'
    end
  end
  resources :visitors, only: [:show, :new, :create]
end
