class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_q, only: [:index, :search]

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
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path if @post.user != current_user
  end

  def update
    @post = Post.find(params[:id])
    return redirect_to posts_path if @post.user != current_user
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def search
    @results = @q.result
  end

  def destroy
    @post = Post.find(params[:id])
    redirect_to posts_path if @post.user != current_user
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :post_text, :image).merge(user_id: current_user.id)
  end

  def set_q
    @q = Post.ransack(params[:q])
  end
end
