class User < ApplicationRecord
  has_secure_password
  before_validation :set_admin, :set_state, :set_indication

  # paginates_per 50
  paginates_per 5

  validates :name_id, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    format: { with: /\A[a-z0-9]+\z/ }, 
    length: { minimum: 1, maximum: 30 }

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :introduction, length: { maximum: 200 }

  # 画像
  # has_one_attached :image
  has_one_attached :user_image

  # articles
  has_many :articles

  # likes Articleとの多対多の関連付け
  has_many :likes
  has_many :like_articles, through: :likes, source: :article

  # パーマリンクをidからname_idに変更する
  def to_param
    # name_id ? name_id : id.to_s
    name_id
  end

  # 記事一覧にある、カレントユーザーがLikeしてるか否かの条件分岐部分のN+1問題の解消
  # Likeのuser_idにカレントユーザが含まれていないかチェック
  def already_liked?(like, current_user_id)
    like.pluck(:user_id).include?(current_user_id)
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
