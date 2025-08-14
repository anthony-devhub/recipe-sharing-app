class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy ]
  before_action :load_categories, only: [ :new, :edit ]

  def index
    @recipes = Recipe.includes(:user, :categories, :ingredients).all
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Recipe created successfully!"
    else
      load_categories
      load_ingredients
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe updated successfully!"
    else
      load_categories
      load_ingredients
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe deleted!"
  end

  def ingredients_async
    @recipe = Recipe.includes(recipe_ingredients: :ingredient).find(params[:id])
    render partial: "recipes/ingredients", locals: { recipe: @recipe }
  end

  def categories_async
    @recipe = Recipe.includes(:categories, :tags).find(params[:id])
    render partial: "recipes/categories", locals: { recipe: @recipe }
  end

  def tags_async
    @recipe = Recipe.includes(:tags).find(params[:id])
    render partial: "recipes/tags", locals: { recipe: @recipe }
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :title, :description, :instructions, :prep_time, :cook_time,
      category_ids: [], ingredient_ids: [], recipe_ingredients_attributes: [ :id, :ingredient_id, :quantity, :unit, :_destroy ]
    )
  end

  def load_categories
    @categories = Category.all
  end

  def load_ingredients
    @ingredients = Ingredient.all
  end
end
