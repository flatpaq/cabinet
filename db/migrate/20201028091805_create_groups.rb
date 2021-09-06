class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.references :user, null: false, foreign_key: true
      t.string :slug, limit: 30, null: false
      t.string :name, limit: 30, null: false
      t.boolean :secret, null: false, default: false

      t.timestamps
      t.index :slug, unique: true
    end
  end
end
