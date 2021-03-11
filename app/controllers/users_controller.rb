class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @self_introduction = user.self_introduction
    @posts = user.posts.includes(:user).order("created_at DESC")
    @consultations = user.consultations.includes(:user).order("created_at DESC")
  end
end
