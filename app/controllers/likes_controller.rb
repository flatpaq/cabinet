class LikesController < ApplicationController

  before_action :before_like_article, only: [:create, :destroy]

  def create

    @like = Like.new(
      user_id: current_user.id, 
      article_id: @article.id
    )

    # レコードが重複していれば保存しない
    @like.save unless Like.find_by(user_id: current_user.id, article_id: params[:article_id])

  end

  def destroy

    @like = Like.find_by(
      user_id: current_user.id,
      article_id: @article.id
    )

    if @like 
      @like.destroy
    end

  end


  # URLのarticle_idを適当な値にしたときの対処
  # 基本的にはArticleのstatusが1の公開状態(opened)かつ、garbage: falseの記事
  # 限定公開(limited)の記事についてはreadableであるかが条件
  # ゴミ箱や下書きに入った記事は自分の記事のため、カレントユーザーであればいいねできる
  private def before_like_article

    article = Article.find_by(id: params[:article_id])

    if article.user_id == current_user.id \
      && article.id != 1

      @article = article

    elsif article.limited? \
      && current_user.article_readable?(article, current_user.id) \
      && article.garbage == false \
      && article.id != 1

      @article = article

    elsif article.opened? \
      && article.garbage == false \
      && article.id != 1

      @article = article

    end

  end

end
