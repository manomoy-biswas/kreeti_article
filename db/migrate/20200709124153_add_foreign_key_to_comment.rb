class AddForeignKeyToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :articles, foreign_key: true
  end
end
