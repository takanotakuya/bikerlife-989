class LikesController < ApplicationController
  before_action :set_post

  def create
  @like = current_user.likes.new(post_id: @post.id)
  @like.save
  @likes = Like.where(post_id: @post.id)
  end

  def destroy
  @like = Like.find_by(post_id: @post.id, user_id: current_user.id).destroy
  @likes = Like.where(post_id: @post.id)
  end

  private

  def set_post
  @post = Post.find(params[:post_id])
  end
end
