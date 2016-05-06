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
  post '/job_offers/:id/accept'  =>  'job_offers#accept', as: "accept_job_offer"
  resources :jobs do
    resources :tasks, except: [:show, :index]
  end

  resources :job_requests do
    member do
      get 'view_offers', to: 'job_offers#index', as: 'view_offers'
    end
  end

  resources :job_requests

####----Below is accepting job offer---
  resources :job_offers do
    member do
      get 'accept', to: 'job_offers#accept', as: 'accept'
    end
  end


  #resources :customers
  resources :contractors, :only => [:create, :delete, :index]
  resources :customers, :only => [:create, :delete]
  get '/customers' => 'customers#dashboard', as: "customer_dashboard"
  #resources :contractors, :only => [:create, :delete]
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
