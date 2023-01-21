class Category < ApplicationRecord
  has_many :category_entities, dependent: :destroy
  has_many :entities, through: :category_entities

  validates :name, presence: true
  validates :image, presence: true

  has_one_attached :image
end
