class IngredientsController < ApplicationController
  def ingredients_async
    @recipe = Recipe.find(params[:id])
    render partial: "recipes/ingredients_list", locals: { recipe: @recipe }
  end
end
