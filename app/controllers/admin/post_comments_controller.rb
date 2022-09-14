class Admin::PostCommentsController < ApplicationController

  def destroy
    post_comment = PostComment.find(params[:id]) #post_comment_id
    post = post_comment.post #post指定
    post_comment.destroy
    redirect_to admin_post_path(post)
  end

end
