class RecipeCategory < ApplicationRecord
  belongs_to :recipe, touch: true
  belongs_to :category
end
