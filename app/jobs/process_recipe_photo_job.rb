class ProcessRecipePhotoJob < ApplicationJob
  queue_as :default

  def perform(recipe_id)
    recipe = Recipe.find(recipe_id)
    nil unless recipe.photo.attached?
  end
end
