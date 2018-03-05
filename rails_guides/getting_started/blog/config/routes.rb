Rails.application.routes.draw do
  # check server log for details
  get 'welcome/index' # map "/welcome/index" to welcome controller's index action

  # `resources` method declares CRUD operations for a resource
  # in a standard REST format.
  # Use `bin/rails routes` to see what it does behind the scene
  resources :articles

  root 'welcome#index' # map root "/" to welcome controller's index action

  
end
