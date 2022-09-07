Rails.application.routes.draw do

  root :to =>"public/homes#top"
   get "about"=>"public/homes#about"

  #ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    #resources :users, only: [:show, :edit, :update]
     # get "users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
      #patch "users/:id/withdraw" => "users#withdraw", as: "withdraw"
    resources :posts, only: [:new, :show, :index, :create, :edit, :update, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  get "users" => "public/users#show", as: "user"
  get "users/info/edit" => "public/users#edit", as: "edit_user"
  patch "users/info" => "public/users#update", as: "update_user"
  get "users/unsubscribe" => "public/users#unsubscribe", as: "unsubscribe"
  patch "users/withdraw" => "public/users#withdraw", as: "withdraw"


  # 会員用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
