class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @image = @user.image
    @self_introduction = @user.self_introduction
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @consultations = @user.consultations.includes(:user).order("created_at DESC")
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :self_introduction, :image)
  end
end
