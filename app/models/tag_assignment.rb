class TagAssignment < ApplicationRecord
  belongs_to :article
  belongs_to :tag

  # validates :article_id, presence: true
  # validates :tag_id, presence: true
end
