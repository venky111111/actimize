Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'

  post 'users/verify_otp', to: 'users#verify_otp'

  resources :base_apps
  resources :user_apps
  resources :base_app_features
   resources :user_app_features
end
