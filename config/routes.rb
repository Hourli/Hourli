Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do
    # Any extra routes for devise users
  end

  root 'home#index'
  get '/contact', to: 'home#contact'
  get '/about-us', to: 'home#about'
  get '/change_role', to: 'change_roles#change_role'

  resources :jobs do
    resources :tasks
  end
  resources :job_requests
  resources :customers, :only => [:create, :delete]
  get '/customer' => 'customers#dashboard', as: "customer_dashboard"
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
