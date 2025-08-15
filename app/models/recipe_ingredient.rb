class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, touch: true
  belongs_to :ingredient
end
