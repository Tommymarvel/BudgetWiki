class Category < ApplicationRecord
  has_many :category_entities, dependent: :destroy
  has_many :entities, through: :category_entities

  validates :name, presence: true
  validates :image, presence: true

def total_amount
    entities.sum(:amount)
  end

  has_one_attached :image
end
