class History < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :user_id, presence: true
  validates :article_id, presence: true

end
