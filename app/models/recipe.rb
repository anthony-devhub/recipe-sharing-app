class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipe_tags, allow_destroy: true
  accepts_nested_attributes_for :recipe_categories, allow_destroy: true

  # has_many_attached :photos # Active Storage

  validates :title, :instructions, presence: true
end
