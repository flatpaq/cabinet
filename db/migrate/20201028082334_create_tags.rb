class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :slug, limit: 30, null: false
      t.string :label, limit: 30, null: false
      t.integer :edit_permit, null: false, default: 0

      t.timestamps
      t.index :slug, unique: true
      t.index :label
    end
  end
end
