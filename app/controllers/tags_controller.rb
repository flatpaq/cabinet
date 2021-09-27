class TagsController < ApplicationController

  before_action :edit_tag_permit, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
      .order(created_at: :desc)
      .page(params[:page])
  end

  # そのタグに紐づく記事一覧を表示する
  def show

    article_ids = current_user.get_article_ids(current_user)

    @tag = Tag.find_by(slug: params[:id])
  
    @articles = @tag.articles.where(id: article_ids, status: [1, 2], garbage: false)
      .order(created_at: :desc)
      .page(params[:page])

  end

  def new
    @tag = Tag.new
  end

  # Article->form画面においてタグを新規に追加するときのアクション
  # def add
  #   @tag = Tag.new(tag_params)
  #   if @tag.save 
  #     @tag = Tag.new
  #   else  
  #   end
  #   @article = Article.new
  # end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_url, notice: "#{@tag.label}タグを作成しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_url, notice: "#{@tag.label}タグを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url, notice: "タグ#{@tag.label}を削除しました。"
  end

  private def tag_params 
    params.require(:tag).permit(:slug, :label, :edit_permit)
  end

  private def edit_tag_permit
    tag = Tag.find_by(slug: params[:id])
    if tag.user_id == current_user.id
      @tag = tag
    elsif tag.any?
      @tag = tag
    end
  end

end
