Rails.application.routes.draw do
  root 'dashboards#index', as: 'home'
  
  match 'login' => 'accounts#login', via: [:get, :post], as: :login
  get 'logout' => 'accounts#logout', as: :logout
  get 'preferences' => 'accounts#preferences', as: :preferences
  get 'status-change/:user_id' => 'users#status_change', as: :status_change
  resources :dashboards
  resources :associates
  resources :users
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
