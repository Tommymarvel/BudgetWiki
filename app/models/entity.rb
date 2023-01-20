class Entity < ApplicationRecord
  has_many :category, through: :category_entities
  has_many :category_entities, dependent: :destroy

  validates :name, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
