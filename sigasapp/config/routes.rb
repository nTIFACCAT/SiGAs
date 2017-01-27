Rails.application.routes.draw do
  root 'dashboards#index', as: 'home'
  
  match 'login' => 'accounts#login', via: [:get, :post], as: :login
  get 'logout' => 'accounts#logout', as: :logout
  get 'preferences' => 'accounts#preferences', as: :preferences
  get 'status-change/:user_id' => 'users#status_change', as: :status_change
  get 'reset-password/:user_id' => 'users#reset_pwd', as: :reset_password
  get 'remove-user/:user_id' => 'users#destroy', as: :remove_user
  get 'remove-category/:id' => 'categories#destroy', as: :remove_category
  get 'associate-status-change/:associate_id' => 'associates#status_change', as: :associate_status_change
  post 'create-direction-role/:associate_id' => 'associates#create_direction_role', as: :create_direction_role
  get 'direction-roles/:associate_id' => 'associates#get_direction_role', defaults: { format: 'json' }, as: :direction_roles
  get 'associate-dependents' => 'associates#get_dependents', defaults: { format: 'json' }, as: :associate_dependents
  get 'associate-dependents/:associate_id' => 'associates#get_dependents_data', defaults: { format: 'json' }, as: :associate_dependents_data
  get 'remove-direction-role/:associate_id/:id' => 'associates#remove_direction_role', as: :remove_direction_role
  get 'remove-dependent/:associate_id/:id' => 'associates#remove_dependent', as: :remove_dependent
  post 'associate-bond/:associate_id' => 'associates#create_associate_bond', as: :create_associate_bond
  resources :dashboards
  resources :associates
  resources :users
  resources :categories
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

