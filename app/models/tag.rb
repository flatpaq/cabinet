class Tag < ApplicationRecord

  paginates_per 50

  validates :slug,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A^[a-z][\-a-z0-9]+\z/ },
    length: { minimum: 3, maximum: 30 }

  validates :label, presence: true, length: { minimum: 3, maximum: 30 }
  validates :edit_permit, presence: true, inclusion: { in: %w(self any) }

  # TODO: selectedは必要ない?
  # validates :edit_permit, presence: true, inclusion: { in: %w(self any selected) }

  enum edit_permit: {
    self: 0, # 自分のみ編集可
    any: 1, # 誰でも編集可
    # selected: 2 # 編集者を選択する
  }

  has_many :tag_assignments, dependent: :destroy
  has_many :articles, through: :tag_assignments
  accepts_nested_attributes_for :tag_assignments, allow_destroy: true

  # パーマリンクをidからslugの文字列に変更する
  def to_param
    slug
  end

end
