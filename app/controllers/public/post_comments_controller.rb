class Public::PostCommentsController < ApplicationController

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to post_path(comment.post), success: t('defaults.message.created', item: Comment.model_name.human)
    else
      redirect_to post_path(comment.post), danger: t('defaults.message.not_created', item: Comment.model_name.human)
    end
  end

  def destroy
    @posts = Post.find(params[:book_id])
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post_comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(post_id: params[:post_id])
  end

end


