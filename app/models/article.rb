class Article < ApplicationRecord
  before_validation :set_titleless_title
  before_validation :set_permalink

  paginates_per 50

  validates :user_id, presence: true
  validates :permalink, 
    presence: true,
    length: { minimum: 3, maximum: 100, message: "の長さは3文字以上200文字以下で設定してください" },
    uniqueness: { case_sensitive: false },
    format: { with: /\A^[a-z][\-a-z0-9]+\z/, message: "の最初の文字は半角英字のみで、それ以降の文字には半角英数字とハイフンを使用することができます" },
    exclusion: { in: %w(new deleted drafts search attach histories),
      message: "%{value}は予約済みの文字列のため使用できません" }
    # allow_blank: true,

  validates :status, presence: true, inclusion: { in: %w(closed opened limited) }
  validates :coedit_permit, presence: true, inclusion: { in: %w(self any selected) }

  validates :title, length: { maximum: 200 }

  belongs_to :user

  has_many :tag_assignments, dependent: :destroy
  has_many :tags, through: :tag_assignments
  accepts_nested_attributes_for :tag_assignments, allow_destroy: true

  # likes UserとArticleの多対多の関連付け
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  # histories ArticleとHistoryの一対多の関連付け
  has_many :histories

  # ReadableArticleUserAssignment 記事の表示権限をユーザーごとに設定する
  # ArticleとUserを関連付ける
  has_many :readable_article_user_assignments, dependent: :destroy
  has_many :readable_article_users, through: :readable_article_user_assignments, source: :user
  accepts_nested_attributes_for :readable_article_user_assignments, allow_destroy: true

  # ReadableArticleGroupAssignment 記事の表示権限をグループごとに設定する
  # ArticleとGroupを関連付ける
  has_many :readable_article_group_assignments, dependent: :destroy
  has_many :readable_article_groups, through: :readable_article_group_assignments, source: :group
  accepts_nested_attributes_for :readable_article_group_assignments, allow_destroy: true

  # WritableArticleUserAssignment 記事の編集権限をユーザーごとに設定する
  # ArticleとUserを関連付ける
  has_many :writable_article_user_assignments, dependent: :destroy
  has_many :writable_article_users, through: :writable_article_user_assignments, source: :user
  accepts_nested_attributes_for :writable_article_user_assignments, allow_destroy: true

  # WritableArticleGroupAssignment 記事の編集権限をグループごとに設定する
  # ArticleとGroupを関連付ける
  has_many :writable_article_group_assignments, dependent: :destroy
  has_many :writable_article_groups, through: :writable_article_group_assignments, source: :group
  accepts_nested_attributes_for :writable_article_group_assignments, allow_destroy: true

  enum status: {
    closed: 0, #非公開,下書き
    opened: 1, #公開
    limited: 2 #公開を限定する
  }

  enum coedit_permit: {
    self: 0, # 自分のみ編集可
    any: 1, # 誰でも編集可
    selected: 2 # 編集者を選択する
  }

  # パーマリンクをidではなくpermalinkの文字列にする
  def to_param
    permalink
  end

  # private

  private def set_titleless_title
    self.title = '題名なし' if title.blank?
  end

  private def set_permalink
    if permalink.blank?

      unless Article.maximum("id").nil?
        max_plus_one = Article.maximum("id") + 1  
      else
        max_plus_one = 1
      end

      set_permalink_name = "article" + max_plus_one.to_s
      self.permalink = set_permalink_name

    end
  end

end
