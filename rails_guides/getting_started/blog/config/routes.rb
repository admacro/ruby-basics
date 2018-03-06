Rails.application.routes.draw do
  # check server log for details
  get 'welcome/index' # map "/welcome/index" to welcome controller's index action

  # `resources` method declares CRUD operations for a resource
  # in a standard REST format.
  # Use `bin/rails routes` to see what it does behind the scene
  #
  # Rails encourges using resources objects instead of declaring routes
  # manually. The routes conform to the REST protocol.
  #
  # Example output:
  #        Prefix Verb   URI Pattern                  Controller#Action
  # welcome_index GET    /welcome/index(.:format)     welcome#index
  #      articles GET    /articles(.:format)          articles#index
  #               POST   /articles(.:format)          articles#create
  #   new_article GET    /articles/new(.:format)      articles#new
  #  edit_article GET    /articles/:id/edit(.:format) articles#edit
  #       article GET    /articles/:id(.:format)      articles#show
  #               PATCH  /articles/:id(.:format)      articles#update
  #               PUT    /articles/:id(.:format)      articles#update
  #               DELETE /articles/:id(.:format)      articles#destroy
  #          root GET    /                            welcome#index
  resources :articles do
    resources :comments
  end

  root 'welcome#index' # map root "/" to welcome controller's index action

  
end
