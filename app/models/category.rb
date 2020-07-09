class Category < ApplicationRecord
  has_many :article
  validates_presence_of :category_name
end
