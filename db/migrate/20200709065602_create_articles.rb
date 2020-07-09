class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :article_name
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
