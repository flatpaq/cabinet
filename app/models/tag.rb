class Tag < ApplicationRecord

  paginates_per 50

  validates :slug,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A^[a-z][\-a-z0-9]+\z/, message: "の最初の文字は半角英字のみで、それ以降の文字には半角英数字とハイフンを使用することができます" },
    length: { minimum: 3, maximum: 30 },
    exclusion: { in: %w(new add search),
      message: "%{value}は予約済みの文字列のため使用できません" }


  validates :label, presence: true, length: { minimum: 3, maximum: 30 }
  validates :edit_permit, presence: true, inclusion: { in: %w(self any) }

  # TODO: selectedは必要ない?
  # validates :edit_permit, presence: true, inclusion: { in: %w(self any selected) }

  enum edit_permit: {
    self: 0, # 自分のみ編集可
    any: 1, # 誰でも編集可
    # selected: 2 # 編集者を選択する
  }

  belongs_to :user

  has_many :tag_assignments, dependent: :destroy
  has_many :articles, through: :tag_assignments
  accepts_nested_attributes_for :tag_assignments, allow_destroy: true

  # パーマリンクをidからslugの文字列に変更する
  def to_param
    slug
  end

end
