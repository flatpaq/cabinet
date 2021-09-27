class Group < ApplicationRecord

  paginates_per 50

  validates :user_id, presence: true

  validates :slug,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A^[a-z][\-a-z0-9]+\z/ },
    length: { minimum: 3, maximum: 30 }

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  # validates :secret, presence: true

  def group_owner
    User.find_by(id: self.user_id)
  end

  # パーマリンクをidからslugの文字列に変更する
  def to_param
    slug
  end

  # belongs_to :user
  
  # group_user_assignments Userとの多対多の関連付け
  has_many :group_user_assignments, dependent: :destroy
  has_many :users, through: :group_user_assignments
  accepts_nested_attributes_for :group_user_assignments, allow_destroy: true

  # ReadableArticleGroupAssignment 記事の表示権限をグループごとに設定する
  # ArticleとGroupを関連付ける
  has_many :readable_article_group_assignments, dependent: :destroy
  has_many :readable_group_articles, through: :readable_article_group_assignments, source: :article

  # WritableArticleGroupAssignment 記事の編集権限をグループごとに設定する
  # ArticleとGroupを関連付ける
  has_many :writable_article_group_assignments, dependent: :destroy
  has_many :writable_group_articles, through: :writable_article_group_assignments, source: :article
  
end
