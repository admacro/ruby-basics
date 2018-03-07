# coding: utf-8
# ruby

class ArticlesController < ApplicationController
  # block access to every action except index and show
  http_basic_authenticate_with name: "james", password: "123", except: [:index, :show]
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
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

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      # passing all the attributes to update is not necessary, you can use 
      # @article.update(title: 'A new title') to only update the title
      # Note: update method accepts hash
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    
    # @article.comments.destroy_all # delete associated comments
    # add `dependent: :destroy` to has_many call in Article model will 
    # make Rails destroy the associated comments automatically

    @article.destroy # you can also use delete
    
    redirect_to articles_path
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
