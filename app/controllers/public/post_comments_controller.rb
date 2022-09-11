class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(id: params[:post_id])
  end

  def destroy
    post_comment = PostComment.find(params[:id]) #post_comment_id
    post = post_comment.post #post指定
    post_comment.destroy
    redirect_to post_path(post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment).merge(post_id: params[:post_id])
  end

end


