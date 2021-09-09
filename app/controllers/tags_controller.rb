class TagsController < ApplicationController

  before_action :edit_tag_permit, only: [:edit, :update]

  def index
    @tags = Tag.all.order(created_at: :desc).page(params[:page])
  end

  # そのタグに紐づく記事一覧を表示する
  def show
    @tag = Tag.find_by(slug: params[:id])
  
    @articles = @tag.articles.where(status: 1, garbage: false)
      .order(created_at: :desc)
      .page(params[:page])

      # .or(@tag.articles.where(user_id: current_user.id, status: 2, garbage: false))
  end

  def new
    @tag = Tag.new
  end

  # Article->form画面においてタグを新規に追加するときのアクション
  def add
    @tag = Tag.new(tag_params)

    if @tag.save 
      @tag = Tag.new
    else  

    end

    @article = Article.new

  end


  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_url, notice: "#{@tag.label}タグを作成しました。"
    else
      render :new
    end
  end

  def edit
    # @tag = Tag.find_by(slug: params[:id])
  end

  def update
    # @tag = Tag.find_by(slug: params[:id])
    if @tag.update(tag_params)
      redirect_to tags_url, notice: "#{@tag.label}タグを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find_by(slug: params[:id])
    @tag.destroy
    redirect_to tags_url, notice: "タグ#{@tag.label}を削除しました。"
  end

  private def tag_params 
    params.require(:tag).permit(:slug, :label, :edit_permit)
  end

  private def edit_tag_permit
    tag = Tag.find_by(slug: params[:id])
    if tag && tag.user_id == current_user.id
      @tag = tag
    elsif tag && tag.any?
      @tag = tag
    end
  end

end
