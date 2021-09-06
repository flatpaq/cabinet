class CreateGroupUserAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :group_user_assignments do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :group, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
