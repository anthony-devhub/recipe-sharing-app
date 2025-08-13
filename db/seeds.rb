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

puts "Seeded #{ingredients.size} ingredients"
