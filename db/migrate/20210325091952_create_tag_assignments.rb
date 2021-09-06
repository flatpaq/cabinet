class CreateTagAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_assignments do |t|
      t.references :article, null: false, index: true, foreign_key: true
      t.references :tag, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
