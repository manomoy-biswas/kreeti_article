class Article < ApplicationRecord
  belongs_to :category
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates_presence_of :article_name, :description

  def self.filter_by(params)
  end
  
  def self.find_article(user)
    Article.where(user_id: user.id).includes(:category)
  end
end
