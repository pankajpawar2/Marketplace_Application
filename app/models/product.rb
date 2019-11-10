class Product < ApplicationRecord  
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_one_attached :picture
  validates :name, :description, :price, presence: true
  validates :price, numericality: true
end
