FactoryBot.define do
  factory :recipe_ingredient do
    association :recipe
    association :ingredient
    quantity { 1.5 }
    unit { "cups" }
  end
end
