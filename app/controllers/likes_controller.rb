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
  # Articleのstatusが1の公開状態(opened)かつ、garbage: falseの記事
  # current_userであれば2の限定公開(limited)も含む これはgroupを作るまで保留
  private def before_like_article

    article = Article.find_by(id: params[:article_id], status: 1, garbage: false)

    if article.user_id == current_user.id && article.id != 1
      @article = article    
    elsif article.id != 1
      @article = article
    end

  end

end
