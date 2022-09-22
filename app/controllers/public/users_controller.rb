class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users=User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
    @currentUserEntry=Entry.where(user_id: current_user.id) # current_userをEntriesテーブルから探す
    @userEntry=Entry.where(user_id: @user.id)  # DMを送る対象のユーザーをEntriesテーブルから探す
    if @user.id != current_user.id
    # currentUserと@userのEntriesをそれぞれ一つずつ取り出し、2人のroomが既に存在するかを確認
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id  # 2人のroomが既に存在していた場合
            @isRoom = true
            @roomId = cu.room_id  #room_idを取り出す
          end
        end
      end
     unless @isRoom # 2人ののroomが存在しない場合
      @room = Room.new
      @entry = Entry.new
     end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      render :usersedit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    #where→与えられた条件にマッチするレコードを全て取得
    #plunk→post_idカラムの一覧を持ってこれる
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :nickname, :email, :introduction, :is_deleted, :image)
  end

end
