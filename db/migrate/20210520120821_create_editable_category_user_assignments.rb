class CreateEditableCategoryUserAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :editable_category_user_assignments do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :category, null: false, index: true, foreign_key: true


      t.timestamps
    end
  end
end
