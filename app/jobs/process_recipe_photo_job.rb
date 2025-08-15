class ProcessRecipePhotoJob < ApplicationJob
  queue_as :default

  def perform(recipe_id)
    recipe = Recipe.find(recipe_id)
    return unless recipe.photo.attached?

    # Process variants
    recipe.photo.variant(:thumb).processed
    recipe.photo.variant(:medium).processed

    # Add metadata extraction if needed
    recipe.update!(
      photo_width: recipe.photo.metadata[:width],
      photo_height: recipe.photo.metadata[:height]
    )
  end
end
