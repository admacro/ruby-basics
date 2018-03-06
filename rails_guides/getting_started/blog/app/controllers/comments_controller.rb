class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id]) # find the associated article

    # @article.comments is an object of ActiveRecord::Associations::CollectionProxy
    # create method will create a new object of Comment with the attributes in
    # comment_params, link it to @article, and save it to DB
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end

