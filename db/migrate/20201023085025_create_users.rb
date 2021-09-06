class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name_id, limit: 30, null: false
      t.string :name, limit: 30, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :introduction, limit: 200
      t.boolean :admin, null: false, default: false
      t.boolean :state, null: false, default: true
      t.boolean :indication, null: false, default: false

      t.timestamps
      t.index :name_id, unique: true
      t.index :email, unique: true
    end
  end
end
