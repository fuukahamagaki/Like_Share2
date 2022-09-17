class Admin::PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
    @post_tags = @post.tags
    @user = @post.user
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

end
