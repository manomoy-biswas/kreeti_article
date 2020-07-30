class Article < ApplicationRecord
  acts_as_votable

  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :likes

  mount_uploader :image, ImageUploader

  validates_presence_of :article_name, :description

  scope :filtered_by_category, -> (id) { where(category_id: id)}
  scope :find_article, -> (user) { where(user_id: user.id).includes(:category, :comments)}
  scope :search, -> (query) { where("article_name LIKE ?", "%#{query}%")}

  def self.filter(id)
    if id == "0" || id == "" || id == nil
      self.includes(:category, :user).all
    else
      self.filtered_by_category(id)
    end
  end

  def self.filtered_by_like(id, param, current_user)
    if param == "" || param == nil || !current_user
      self.filter(id)
    elsif param == "Liked" && param
        self.joins(:likes).where(likes: {user_id: current_user.id})
    end
  end
end
