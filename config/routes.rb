Rails.application.routes.draw do

  # 会員用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root :to =>"public/homes#top"
   get "about"=>"public/homes#about"


  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update] do
      member do
       get :favorites
      end
    end
     get "users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
     patch "users/:id/withdraw" => "users#withdraw", as: "withdraw"
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :show, :index]
    resources :posts, only: [:new, :show, :index, :create, :edit, :update, :destroy] do
     resources :post_comments, only: [:create, :destroy], shallow: true #shallow→createとdestroyだけpost_idが欲しいのでonly
     resource :favorites, only: [:create, :destroy]
     collection do #検索機能
      get 'search'
     end
    end
  end

  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy], shallow: true
    end
  end
   # タグの検索で使用する
   get "search_tag"=>"public/posts#search_tag"


 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
