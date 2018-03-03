Rails.application.routes.draw do
  # check server log for details
  get 'welcome/index' # map "/welcome/index" to welcome controller's index action

  resources :articles

  root 'welcome#index' # map root "/" to welcome controller's index action

  
end
