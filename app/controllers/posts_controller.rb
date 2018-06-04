class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_current_user, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @user.posts.all
  end

  def show
  end

  def new
    @post = @user.posts.new
  end

  def edit
  end

  def create
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to [@user, @post], notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to [@user, @post], notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
  
    def set_current_user
      @user = current_user
    end

    def set_user
      @user = User.includes(:posts).find(params[:user_id])
    end

    def set_post
      @post = @user.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :content)
    end
end
