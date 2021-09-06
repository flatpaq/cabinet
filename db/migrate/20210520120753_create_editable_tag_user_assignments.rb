class CreateEditableTagUserAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :editable_tag_user_assignments do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :tag, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
