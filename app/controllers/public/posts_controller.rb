class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index] #ユーザーがログインしているかどうか（show,indexを除く）
  #before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.post_tags.build
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.includes(:user).order(created_at: :desc)
    @post_tags = @post.tags
    @user = @post.user
  end

  def index
    @posts = Post.all
    @post = Post.new
    @tag_list = Tag.all
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id), notice: "投稿しました"
    else
      @posts = Post.all
      @user = current_user
      render 'show'
    end
  end

  def edit
    @post = Post.find(params[:id])
     # pluckはmapと同じ意味
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
        @post.save_tag(tag_list)
        redirect_to post_path(@post), notice: "更新しました"
    else
        render "edit"
    end
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts = @tag.posts#.page(params[:page]).per(10)
  end

  def search
    @posts = Post.search(params[:keyword])
    #@tag_name = @posts
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body) #:image
  end

  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to(posts_path) unless @user == current_user
  end

end
