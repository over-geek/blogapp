class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @post = Post.find(params[:post_id])
    @user = @post.author
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params.merge(post: @post))
    @comment.author = current_user

    if @comment.save
      flash[:success] = 'Comment successfully added! 😎'
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = 'Comment not added! 😢'
      puts flash[:alert]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
