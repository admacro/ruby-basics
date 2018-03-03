class ArticlesController < ApplicationController
  def new
  end

  def create
    # => <ActionController::Parameters {"title"=>"Intuition", "text"=>"I found it!"} permitted: false>
    # params is an ActionController::Parameters object
    render plain: params[:article].inspect
  end
end
