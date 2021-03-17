class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_q, only: [:index, :search]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :redirect, only: [:edit, :destroy]

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
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
  end

  def edit
  end

  def update
    return redirect_to posts_path if @post.user != current_user
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def search
    @results = @q.result
  end

  private

  def post_params
    params.require(:post).permit(:name, :post_text, images: []).merge(user_id: current_user.id)
  end

  def set_q
    @q = Post.ransack(params[:q])
  end

  def set_item
    @post = Post.find(params[:id])
  end

  def redirect
    redirect_to posts_path if @post.user != current_user
  end
end
