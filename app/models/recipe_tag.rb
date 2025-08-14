class RecipeTag < ApplicationRecord
  belongs_to :recipe, touch: true
  belongs_to :tag
end
