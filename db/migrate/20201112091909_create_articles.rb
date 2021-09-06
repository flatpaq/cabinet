class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :category_id
      t.string :permalink, null: false
      t.integer :status, null: false, default: 0
      t.integer :coedit_permit, null: false, default: 0
      t.boolean :garbage, null: false, default: false
      t.datetime :published_at
      
      t.timestamps
      t.index :title
      t.index :content
      t.index :permalink, unique: true
    end
  end
end
