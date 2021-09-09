class AddUserIdToTags < ActiveRecord::Migration[6.0]
  def change
    add_reference :tags, :user, null: false
  end

  def down
    remove_reference :tags, :user
  end
end
