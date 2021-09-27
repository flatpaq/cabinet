class User < ApplicationRecord
  has_secure_password
  before_validation :set_admin, :set_state, :set_indication

  paginates_per 50

  validates :name_id, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    format: { with: /\A[a-z0-9]+\z/ }, 
    length: { minimum: 1, maximum: 30 }

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :introduction, length: { maximum: 200 }

  # 画像
  has_one_attached :user_image

  # articles
  has_many :articles

  # likes Articleとの多対多の関連付け
  has_many :likes, dependent: :destroy
  has_many :like_articles, through: :likes, source: :article

  # group_user_assignments Groupとの多対多の関連付け
  has_many :group_user_assignments, dependent: :destroy
  has_many :groups, through: :group_user_assignments

  # ReadableArticleUserAssignment 記事の表示権限をユーザーごとに設定する
  # ArticleとUserを関連付ける
  has_many :readable_article_user_assignments, dependent: :destroy
  has_many :readable_user_articles, through: :readable_article_user_assignments, source: :article

  # WritableArticleUserAssignment 記事の編集権限をユーザーごとに設定する
  # ArticleとUserを関連付ける
  has_many :writable_article_user_assignments, dependent: :destroy
  has_many :writable_user_articles, through: :writable_article_user_assignments, source: :article

  # パーマリンクをidからname_idに変更する
  def to_param
    name_id
  end

  # 記事一覧にある、カレントユーザーがLikeしてるか否かの条件分岐部分のN+1問題の解消
  # Likeのuser_idにカレントユーザが含まれていないかチェック
  def already_liked?(like, current_user_id)
    like.pluck(:user_id).include?(current_user_id)
  end

  # カレントユーザーに書き込み権限のある記事かどうか判定する
  # 呼び出しはif current_user.article_writable?(article, current_user.id)
  def article_writable?(article, current_user_id)

    writable_group_ids = article.writable_article_group_assignments.pluck(:group_id)
    writable_group_ids ||= []

    writable_user_ids = GroupUserAssignment.where(group_id: writable_group_ids).pluck(:user_id)
    writable_user_ids += article.writable_article_user_assignments.pluck(:user_id)

    writable_user_ids << article.user_id

    # 重複を削除
    writable_user_ids = writable_user_ids.uniq

    # 配列の中にcurrent_userのidが含まれているか確認
    writable_user_ids&.include?(current_user_id)
  
  end

  def article_readable?(article, current_user_id)

    readable_group_ids = article.readable_article_group_assignments.pluck(:group_id)
    readable_group_ids ||= []

    readable_user_ids = GroupUserAssignment.where(group_id: readable_group_ids).pluck(:user_id)

    readable_user_ids += article.readable_article_user_assignments.pluck(:user_id)

    readable_user_ids << article.user_id

    # 重複を削除
    readable_user_ids = readable_user_ids.uniq

    # 配列の中にcurrent_userのidが含まれているか確認
    readable_user_ids&.include?(current_user_id)

    # 参考
    # elsif article.readable_article_user_assignments.exists?(user_id: current_user.id) \
    #   || GroupUserAssignment.where(group_id: readable_group_ids).exists?(user_id: current_user.id)

  end

  def get_article_ids(user)

    # 記事とユーザー間で読み取り制限を設定した記事
    # これで該当のidsをuser_article_ids配列で取得
    user_article_ids = user.readable_article_user_assignments.pluck(:article_id)
    user_article_ids ||= []

    # 記事とグループ間での読み取り制限を設定した記事
    # これで該当のidsをgroup_article_ids配列に取得
    group_ids = user.group_user_assignments.pluck(:group_id)
    group_ids ||= []
    group_article_ids = ReadableArticleGroupAssignment.where(group_id: group_ids).pluck(:article_id)
    group_article_ids ||= []

    # カレントユーザーの限定公開にしている記事を出力
    current_article_ids = user.articles.where(status: 2).pluck(:id)
    current_article_ids ||= []

    # 公開されている記事の取得
    general_article_ids = Article.where(status: 1).pluck(:id)
    general_article_ids ||= []

    # 該当する全ての記事のidsをarticle_idsにまとめる
    article_ids = user_article_ids + group_article_ids + current_article_ids + general_article_ids

    # 重複しているidを削除
    @article_ids = article_ids.uniq

  end

  # private

  private def set_admin
    self.admin = false if admin.nil?
  end

  private def set_state
    self.state = true if state.nil?
  end

  private def set_indication
    self.indication = false if indication.nil?
  end


end
