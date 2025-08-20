# --- Users ---
users = [
  { email: "anthony@example.com", password: "password123" },
  { email: "john_doe@example.com", password: "password123" },
  { email: "jane_doe@example.com", password: "password123" }
]

users.each do |u|
  User.find_or_create_by!(email: u[:email]) do |user|
    user.password = u[:password]
    user.password_confirmation = u[:password]
  end
end

Rails.logger.debug { "Seeded #{users.size} demo users" }

# --- Ingredients ---
ingredients = [
  { name: "Flour", unit: "grams" },
  { name: "Sugar", unit: "grams" },
  { name: "Eggs", unit: "pcs" },
  { name: "Butter", unit: "grams" },
  { name: "Milk", unit: "ml" },
  { name: "Salt", unit: "grams" },
  { name: "Baking Powder", unit: "grams" },
  { name: "Vanilla Extract", unit: "ml" },
  { name: "Olive Oil", unit: "ml" },
  { name: "Cocoa Powder", unit: "grams" },
  { name: "Honey", unit: "grams" },
  { name: "Yeast", unit: "grams" },
  { name: "Cheddar Cheese", unit: "grams" },
  { name: "Tomato Paste", unit: "grams" },
  { name: "Garlic", unit: "cloves" },
  { name: "Onion", unit: "pcs" },
  { name: "Carrot", unit: "pcs" },
  { name: "Bell Pepper", unit: "pcs" },
  { name: "Chicken Breast", unit: "grams" },
  { name: "Salmon Fillet", unit: "grams" },
  { name: "Basil", unit: "grams" },
  { name: "Oregano", unit: "grams" },
  { name: "Black Pepper", unit: "grams" },
  { name: "Lemon Juice", unit: "ml" },
  { name: "Soy Sauce", unit: "ml" }
]

ingredients.each do |ing|
  Ingredient.find_or_create_by!(ing)
end

Rails.logger.debug { "Seeded #{ingredients.size} ingredients" }

# --- Categories & Tags ---
categories = %w[Breakfast Lunch Dinner Dessert Snack]
tags = %w[Vegan Vegetarian Gluten-Free Quick Easy]

categories.each { |name| Category.find_or_create_by!(name: name) }
tags.each { |name| Tag.find_or_create_by!(name: name) }

Rails.logger.debug { "Seeded #{categories.size} categories and #{tags.size} tags" }

# --- Demo Recipes ---
if Recipe.count == 0
  User.find_each do |user|
    2.times do |i|
      recipe = Recipe.create!(
        user: user,
        title: "#{user.email.split('@').first.capitalize}'s Recipe #{i + 1}",
        description: "Delicious recipe made by #{user.email}",
        instructions: "Step 1: Do something.\nStep 2: Do something else.",
        prep_time: rand(5..30),
        cook_time: rand(10..60)
      )

      # Assign random ingredients
      Ingredient.order("RANDOM()").limit(5).each do |ing|
        recipe.recipe_ingredients.create!(
          ingredient: ing,
          quantity: rand(50..500),
          unit: ing.unit || "grams"
        )
      end

      # Assign random category and tag
      recipe.categories << Category.order("RANDOM()").first
      recipe.tags << Tag.order("RANDOM()").first
    end
  end

  Rails.logger.debug "Seeded demo recipes with ingredients, categories, and tags"
end
