Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    # Any extra routes for devise users
  end

  root 'home#index'
  get '/contact', to: 'home#contact'
  get '/about-us', to: 'home#about'
  get '/change_role', to: 'change_roles#change_role'

  get '/job_requests/search' => 'job_requests#search', as: "search_job_requests"
  resources :jobs do
    resources :tasks, except: [:show, :index]
  end
  resources :job_requests do
    member do
      get 'view_offers', to: 'job_requests#view_offers', as: 'view_offers'
    end
  end
  resources :customers, :only => [:create, :delete]
  get '/customers' => 'customers#dashboard', as: "customer_dashboard"
  resources :contractors, :only => [:create, :delete]
  get '/contractor/edit' => 'contractors#edit', as: "edit_contractor"
  put '/contractor/update' => 'contractors#update', as: "update_contractor"
  resources :contractors
  resources :notifications, only: [:index] do
    member do
      put :toggle_read_status
      put :hide
    end
  end
end
