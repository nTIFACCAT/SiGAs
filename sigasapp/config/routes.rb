Rails.application.routes.draw do
  root 'dashboards#index', as: 'home'
  
  match 'login' => 'accounts#login', via: [:get, :post], as: :login
  get 'logout' => 'accounts#logout', as: :logout
  get 'preferences' => 'accounts#preferences', as: :preferences
  get 'status-change/:user_id' => 'users#status_change', as: :status_change
  get 'reset-password/:user_id' => 'users#reset_pwd', as: :reset_password
  get 'remove-user/:user_id' => 'users#destroy', as: :remove_user
  resources :dashboards
  resources :associates
  resources :users
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

