class Product < ApplicationRecord  
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_one_attached :picture
end
