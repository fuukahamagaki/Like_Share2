class Public::FavoritesController < ApplicationController

  def create
   @post = Post.find(params[:post_id])
   @favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
   @favorite.save
   redirect_to post_path(params[:post_id])
  end

  def destroy
   @favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
   @favorite.destroy
   redirect_to post_path(params[:post_id])
  end

end
