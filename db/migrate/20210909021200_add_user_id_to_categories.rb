class AddUserIdToCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :user, null: false
  end
  
  def down
    remove_reference :categories, :user
  end
end
