class AddLikeIn < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :like, :bigint
  end
end
