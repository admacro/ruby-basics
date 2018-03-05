# coding: utf-8
# ruby

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end

  def create
    # params is an object of ActionController::Parameters
    # render plain: params[:article].inspect
    puts plain: params[:article]

    # using ActiveModel
    # mass update will raise ActiveModel::ForbiddenAttributesError
    # @article = Article.new(params[:article])
    
    @article = Article.new(article_params)

    # ActiveRecord::Persistence.save
    # returns a boolean indicating whether the article is saved or not
    if @article.save
      redirect_to @article
    else
      render 'new' # request forwarding, @article is passed to `new` template
    end
  end

  private
  
  def article_params
    # use Strong Parameters to whitelist attributes for update
    #
    # `require` returns associated value of the key passed if exists
    #   raise error if key doest not exist or is empty, blank ("\t"), nil, or {}
    #
    # `permit` returns a new instance of ActionParameters with passed arributes
    #   and sets `permitted` attribute to true (default is false)

    puts params.require(:article)
    # => {"title"=>"Save Web", "text"=>"not saved"}
    
    puts params.require(:article).permit(:title)
    # => Unpermitted parameter: :text
    # => {"title"=>"Save Web"}
    
    params.require(:article).permit(:title, :text)
  end
end
