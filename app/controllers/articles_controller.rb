class ArticlesController < ApplicationController

  before_action :edit_article_permit, only: [:edit, :update]

  before_action :destroy_article_permit, only: [:destroy]
  before_action :garbage_article_permit, only: [:disposal, :restore]

  # Ransackによる検索機能
  before_action :set_q, only: [:index, :show, :search]


  # トップページ
  def top_page
    @article = Article.first
    @histories = @article.histories.includes(:user).order(created_at: :desc).limit(10)
  end

  def index

    @articles = Article.where.not(id: 1).where(status: 1, garbage: false)
      .includes(:user, {user: {user_image_attachment: :blob}}, :tags, :histories, :likes)
      .order(created_at: :desc)
      .page(params[:page])

  end

  # Ransackによる検索結果一覧
  def search

    @results = @q.result(distinct: true)
      .where.not(id: 1)
      .where(status: 1, garbage: false)
      .includes(:user, {user: {user_image_attachment: :blob}}, :tags, :histories, :likes)
      .order(created_at: :desc)
      .page(params[:page])

  end

  def show

    article = Article.find_by(permalink: params[:id])

    if article.user_id == current_user.id

      # NOTE: @article = article でいけると思う
      @article = current_user.articles.includes(:tags, :histories, :likes)
        .find_by(permalink: params[:id], status: [0, 1, 2])
      
    else
    # NOTE: 以下2行で書き換えられそう
    # elsif article.opened? && article.garbage == false
      # @article = article

      @article = Article.includes(:tags, :histories, :likes)
        .find_by(permalink: params[:id], status: 1, garbage: false)

    end
 
    @histories = @article.histories.select(:id, :user_id, :article_id, :created_at).includes(:user).order(created_at: :desc).limit(10)

  end

  # 画像添付
  def attach
    attachment = Attachment.create! image: params[:image]
    render json: { filename: url_for(attachment.image) }
  end

  def new
    @article = Article.new
    @tag = Tag.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save

      @history = @article.histories.new(
        user_id: current_user.id,
        title: @article.title,
        content: @article.content
      )
      @history.save

      redirect_to article_url(@article), notice: "#{@article.title}を作成しました。"
    else
      render :new
    end
  end

  def edit
    @tag = Tag.new

    @histories = @article.histories.select(:id, :user_id, :article_id, :created_at).includes(:user).order(created_at: :desc).limit(10)
  
  end

  # 記事の内容を変更履歴から復元する場合
  def revert

  end

  # HACK: もう少し綺麗なコードにできると思う
  def update

    if @article.id == 1

      if @article.update(top_article_params)

        @history = @article.histories.new(
          user_id: current_user.id,
          title: @article.title,
          content: @article.content
        )
        @history.save

        redirect_to root_url, notice: "#{@article.title}を更新しました。"

      else
        render :edit
      end

    elsif @article.user_id == current_user.id

      if @article.update(article_params)

        @history = @article.histories.new(
          user_id: current_user.id,
          title: @article.title,
          content: @article.content
        )
        @history.save

        redirect_to article_url(@article), notice: "#{@article.title}を更新しました。"

      else
        render :edit
      end

    else

      # 共同編集権限があったとしても、article.idがcurrent_user.idではない場合は、渡すパラメータを制限する
      if @article.update(other_user_article_params)

        @history = @article.histories.new(      
          user_id: current_user.id,
          title: @article.title,
          content: @article.content
        )
        @history.save

        redirect_to article_url(@article), notice: "#{@article.title}を更新しました。"

      else
        render :edit
      end

    end

  end


  # 特定の記事をいいねしたユーザーを表示する
  def liked_user
    @article = Article.find_by(permalink: params[:id], status: 1, garbage: false)

    liked_user_ids = @article.likes.pluck(:user_id)

    @users = User.where(id: liked_user_ids).includes({user_image_attachment: :blob})


    # NOTE: 上記のコード2行で実現できるかも SQLリクエストも減る?
    # liked_user_ids = Like.where(article_id: Article.find_by(permalink: params[:id], status: 1, garbage: false).select(:id)).pluck(:user_id)
    # @users =  User.where(id: liked_user_ids).includes({user_image_attachment: :blob})
    # -----
    
  end

  # カレントユーザの保持している下書きを一覧表示する
  def drafts
    @articles = current_user.articles.where(status: 0, garbage: false)
      .order(created_at: :desc)
      .page(params[:page])
  end

  # カレントユーザの、ゴミ箱に入れた記事を出力する
  def deleted
    @articles = current_user.articles.where(garbage: true)
      .order(created_at: :desc)
      .page(params[:page])
  end

  # 記事をゴミ箱に入れる
  def disposal
    if @article.garbage == false
      @article.garbage = true
      @article.save
      redirect_to articles_url, notice: "#{@article.title}を削除しました。"
    else
      render :show
    end
  end

  # 記事をゴミ箱から復元する
  def restore
    if @article.garbage == true
      @article.garbage = false
      @article.save
      redirect_to articles_url, notice: "#{@article.title}を復元しました。"
    else
      render :show
    end
  end

  # 記事をDBからハードデリートする 管理者のみが実行可能
  def destroy
    @article.destroy
    redirect_to articles_url, notice: "#{@article.title}を完全に削除しました。"
  end

  # private

  private def article_params
    params.require(:article).permit(:title, :content, :permalink, :status, :garbage, :coedit_permit, { tag_ids: [] })
  end

  private def other_user_article_params
    params.require(:article).permit(:title, :content, :permalink, { tag_ids: [] })
  end

  private def top_article_params
    params.require(:article).permit(:title, :content, :permalink)
  end

  # 現状 カレントユーザのみ編集ができる
  # TODO: 今後 書き込み許可されたグループあるいはユーザの処理を行う
  # 記事がゴミ箱に入っていると編集はできない
  private def edit_article_permit
    article = Article.find_by(permalink: params[:id], garbage: false)
    if article.user_id == current_user.id
      @article = article
    elsif article.any? && article.opened?
      @article = article
    end
  end

  # 管理者のみが記事を完全に削除できるようにする
  private def destroy_article_permit
    article = Article.find_by(permalink: params[:id])
    if current_user.admin? && article.id != 1
      @article = article
    end
  end

  # カレントユーザのみが記事をゴミ箱に入れたり復元したりできる
  private def garbage_article_permit
    article = Article.find_by(permalink: params[:id])
    if article.user_id == current_user.id && article.id != 1
      @article = article
    end
  end

  private def set_q
    # スペースで区切った複数ワードの検索処理
    unless params[:q].blank?
      words = params[:q].delete(:title_or_content_or_permalink_cont) if params[:q].present?
      if words.present?
        params[:q][:groupings] = []
        words.split(/[ 　]/).each_with_index do |word, i| 
          params[:q][:groupings][i] = { title_or_content_or_permalink_cont: word }
        end
      end
    end
    # 検索結果のコレクションをqに格納
    @q = Article.ransack(params[:q])
  end

end
