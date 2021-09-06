class CreateCategoryAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :category_assignments do |t|
      t.references :article, null: false, index: true, foreign_key: true
      t.references :category, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
