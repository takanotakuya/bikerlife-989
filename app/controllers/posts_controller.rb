class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path if @post.user != current_user
  end

  def update
    @post = Post.find(params[:id])
    redirect_to posts_path if @post.user != current_user
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :post_text, :image).merge(user_id: current_user.id)
  end
end
