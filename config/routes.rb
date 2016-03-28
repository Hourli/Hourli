Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/contact', to: 'home#contact'
  get '/about-us', to: 'home#about'
  get '/change_role', to: 'change_roles#change_role'
  resources :jobs
  resources :job_requests
  resources :customers
  resources :contractors
end
