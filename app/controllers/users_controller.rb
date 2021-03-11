class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @self_introduction = @user.self_introduction
    @posts = @user.posts.includes(:user).order("created_at DESC")
    @consultations = @user.consultations.includes(:user).order("created_at DESC")
    # @post = user.post(params[:id])
    # @consultation = user.consultation.find(params[:id])
  end

  def edit
  end

  # def update
  #   if current_user.update(user_params)
  #     redirect_to user_path
  #   else
  #     render :edit
  #   end
  # end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :self_introduction)
  end
end
