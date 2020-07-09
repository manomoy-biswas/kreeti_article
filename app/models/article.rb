class Article < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comment

  mount_uploader :image, ImageUploader

  validates_presence_of :article_name, :description
  
  def self.find_article(user)
    Article.where(user_id: user.id).includes(:category)
  end
end
