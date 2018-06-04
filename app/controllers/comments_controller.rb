class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @post = @user.find(params[:post_id])
    @comments = @post.comments.all
  end

  def show
  end

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post_id: @post.id)
  end

  def edit
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(comment_params)

    if @comment.save
      redirect_to [@user, @post], notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to [@user, @post], notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    
    def set_comment
      @user = User.find(params[:user_id])
      @post = @user.find(params[:post_id])
      @comment = @post.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :content)
    end
end
