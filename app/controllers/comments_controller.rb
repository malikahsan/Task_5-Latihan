class CommentsController < ApplicationController
  def index
    
  end

  def new
    @comment = Comment.new
  end
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params_comment)
    @comment.status = "active"
    @comment.user_id = current_user.id
    
    if @comment.save
      flash[:notice] = "Success Add Comment"
      
      redirect_to article_url params[:article_id]
    else
      flash[:errors] = "Data not valid"
      render "new"
    end
  end

  def edit
    
  end
  
  private
  def params_comment
    params.require(:comment).permit(:article_id, :user_id, :content, :status)
  end
end
