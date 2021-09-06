class Article < ApplicationRecord
  before_validation :set_titleless_title
  before_validation :set_permalink

  # paginates_per 50
  paginates_per 10

  validates :user_id, presence: true
  validates :permalink, 
    presence: true,
    length: { minimum: 3, maximum: 100 },
    uniqueness: { case_sensitive: false },
    format: { with: /\A^[a-z][\-a-z0-9]+\z/ },
    exclusion: { in: %w(deleted drafts search attach),
      message: "%{value}は予約済みです" }
    # allow_blank: true,
    # format: { with: /\A[a-z]{1}[a-z0-9]+\z/}


  validates :status, presence: true, inclusion: { in: %w(closed opened limited) }
  validates :coedit_permit, presence: true, inclusion: { in: %w(self any selected) }
  # validates :garbage, presence: true

  validates :title, length: { maximum: 200 }

  belongs_to :user

  has_many :tag_assignments, dependent: :destroy
  has_many :tags, through: :tag_assignments
  accepts_nested_attributes_for :tag_assignments, allow_destroy: true
  # accepts_nested_attributes_for :tags

  # likes UserとArticleの多対多の関連付け
  has_many :likes
  has_many :users, through: :likes

  # histories ArticleとHistoryの一対多の関連付け
  has_many :histories




  enum status: {
    closed: 0, #非公開,下書き
    opened: 1, #公開
    limited: 2 #限定公開
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
