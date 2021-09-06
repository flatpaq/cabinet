class CreateWritableArticleGroupAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :writable_article_group_assignments do |t|
      t.references :group, null: false, index: true, foreign_key: true
      t.references :article, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
