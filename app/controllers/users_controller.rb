class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @posts = user.posts.includes(:user).order("created_at DESC")
    @consultations = user.consultations.includes(:user).order("created_at DESC")
  end
end
