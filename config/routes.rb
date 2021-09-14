Rails.application.routes.draw do

  # root to: 'articles#index'
  root to: 'articles#top_page'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # User
  resources :users, except: [:destroy] do

    member do
      post 'disable', to: 'users#disable'
      post 'enable', to: 'users#enable'
    end

    collection do
      get 'search', to: 'users#search'
    end

  end

  # Article
  resources :articles do
    member do
      # 記事をゴミ箱に入れる
      post 'disposal', to: 'articles#disposal'

      # 記事をゴミ箱から復元する
      post 'restore', to: 'articles#restore'

      # ある記事に対していいねしたユーザーを表示する
      get 'liked_user', to: 'articles#liked_user'
    end

    collection do
      # ゴミ箱に入れた記事を表示する
      get 'deleted', to: 'articles#deleted'

      # 下書き記事の一覧を表示する
      get 'drafts', to: 'articles#drafts'
      
      # 記事の検索
      get 'search', to: 'articles#search'

      # 記事に画像を埋め込む
      post 'attach', to: 'articles#attach'      
    end
  end

  # Tag
  resources :tags do
    collection do
      post 'add', to: 'tags#add'
    end
  end
  
  # Like
  post '/likes/:article_id', to: 'likes#create'
  delete '/likes/:article_id', to: 'likes#destroy'

  # History
  get '/articles/:article_id/histories/:id', to: 'articles#history_view'
  post '/articles/:article_id/histories/:id', to: 'articles#revert'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
