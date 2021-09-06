class Category < ApplicationRecord
  has_ancestry


  enum edit_permit: {
    self: 0, # 自分のみ編集可
    any: 1, # 誰でも編集可
    selected: 2 # 編集者を選択する
  }

end
