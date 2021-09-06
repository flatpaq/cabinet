class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :slug, limit: 30, null: false
      t.string :label, limit: 30, null: false
      t.string :ancestry, index: true
      t.integer :edit_permit, null: false, default: 0

      t.timestamps
      t.index [:slug, :ancestry], unique: true
    end
  end
end
