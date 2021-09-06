class UsersController < ApplicationController


  # -------------------
  # パスワード再設定
  # UserControllerじゃなくていいかもしれない
  # これやめてDeviseに移行する
  # Deviseはcurrent_user使える
  # 不要なファイル消せば移行はスムーズにいけるはず
  skip_before_action :login_required, only: :password_reset

  def password_reset
    user = User.find_by(email: email_reset_params[:email], state: true)
    if user
      # 時間制限あるPWリセットメールを送信する処理
    end
  end

  # パスワード再設定用のストロングパラメーター
  private def email_reset_params
    params.require(:session).permit(:email)
  end
  # -------------------


  # 管理者でなければnew, create, disable, enableは行えない
  before_action :require_admin, only: [:new, :create, :disable, :enable]

  # 自分のアカウントのedit, updateは行える。他ユーザのedit, updateは行うことができないようにする
  # カレントユーザが管理者であればedit, updateを行える
  before_action :ensure_correct_user, only: [:edit, :update]

  # Ransackによる検索
  before_action :set_q, only: [:index, :show, :search]

  # Ransackによる検索
  def search
    if current_user.admin?
      @results = @q.result(distinct: true)
        .order(created_at: :desc).page(params[:page])
    else
      @results = @q.result(distinct: true)
        .where(state: true)
        .order(created_at: :desc).page(params[:page])
    end
  end

  def index
    if current_user.admin?
      @users = User.all
        .includes({user_image_attachment: :blob})
        .order(created_at: :desc).page(params[:page])
    else
      @users = User.where(state: true)
        .includes({user_image_attachment: :blob})
        .order(created_at: :desc).page(params[:page])
    end
  end

  # User.with_attached_user_imageかincludes({user_image_attachment: :blob})

  def show
    if current_user.admin?
      @user = User.find_by(name_id: params[:id])
    else
      @user = User.find_by(name_id: params[:id], state: true)
    end

    if @user
      # 各ユーザの記事一覧を出力
      if @user.id == current_user.id
        @articles = @user.articles
          .where.not(id: 1)
          .where(status: [0, 1, 2], garbage: false)
          .includes(:tags, :likes)
          .order(created_at: :desc)
          .page(params[:page])

        redirect_to root_url unless @articles
      else
        @articles = @user.articles
          .where(status: 1, garbage: false)
          .includes(:tags, :likes)
          .order(created_at: :desc)
          .page(params[:page])

        redirect_to root_url unless @articles
      end

      # ユーザーがいいねした記事を出力する
      # selectじゃなくてpluckのほうがいい?
      likes = @user.likes.select(:article_id)
      @liked_articles = Article
        .where(id: likes, status: 1, garbage: false)
        .includes(:user, {user: {user_image_attachment: :blob}}, :tags, :histories, :likes)

    else
      redirect_to root_url
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_admin)

    if @user.save
      redirect_to user_url(@user), notice: "#{@user.name}をユーザー登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update

    # @user.user_image.purgeで古い画像を削除しておく?

    if current_user.admin?
      if @user.update(user_params_admin)
        redirect_to user_url(@user), notice: "#{@user.name}のユーザー情報を更新しました。"
      else
        render :edit
      end

    else

      if @user.update(user_params)
        redirect_to user_url(@user), notice: "#{@user.name}のユーザー情報を更新しました。"
      else
        render :edit
      end

    end
  end

  def disable
    @user = User.find_by(name_id: params[:id])
    # 自分自身は無効化できないようにする?
    # redirect_to users_url if @user.id == current_user.id
    @user.state = false
    if @user.save
      redirect_to users_url, notice:  "#{@user.name}のユーザーアカウントを無効にしました。"
    else
      redirect_to users_url
    end
  end

  def enable
    @user = User.find_by(name_id: params[:id])
    @user.state = true
    if @user.save
      redirect_to users_url, notice:  "#{@user.name}のユーザーアカウントを有効にしました。"
    else
      redirect_to users_url
    end
  end

  # private

  # user_paramsの種類を増やす?
  # adminがユーザーのcreateをする際は:user_imageや:introductionを触る必要はない
  # adminが他ユーザーのupdateをする際は:user_imageや:introductionに加えて:nameや:passwordを変える必要はない
  # adminが自身のプロフィールをupdateする際は制限はない
  # 普通のuserが自身のプロフィールをupdateする際は現在のuser_paramsでよい

  private def user_params_admin
    params.require(:user).permit(:name_id, :name, :email, :user_image, :introduction, :admin, :state, :password, :password_confirmation)
  end

  private def user_params
    params.require(:user).permit(:name_id, :name, :email, :user_image, :introduction, :password, :password_confirmation)
  end

  private def require_admin
    redirect_to root_url unless current_user.admin?
  end

  private def ensure_correct_user
    user = User.find_by(name_id: params[:id])
    if user && (user.id == current_user.id || current_user.admin?)
      @user = user
      redirect_to root_url unless @user
    else
      redirect_to root_url
    end
  end

  private def set_q
    # スペースで区切った複数ワードの検索処理
    unless params[:q].blank?
      words = params[:q].delete(:name_or_name_id_or_email_cont) if params[:q].present?
      if words.present?
        params[:q][:groupings] = []
        words.split(/[ 　]/).each_with_index do |word, i| 
          params[:q][:groupings][i] = { name_or_name_id_or_email_cont: word }
        end
      end
    end
    # Ransackを用いた検索
    @q = User.ransack(params[:q])
  end


end
