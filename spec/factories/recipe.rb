FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "Recipe #{n}" }
    description { "Test Description" }
    instructions { "Detailed cooking instructions" }
    prep_time { 10 }
    cook_time { 20 }
    association :user

    trait :with_photo do
      after(:build) do |recipe|
        recipe.photo.attach(
          io: File.open(Rails.root.join('spec/fixtures/valid_image.jpg')),
          filename: 'recipe.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_categories do
      after(:create) do |recipe|
        recipe.categories << create(:category)
      end
    end

    trait :with_tags do
      after(:create) do |recipe|
        recipe.tags << create(:tag)
      end
    end

    trait :with_ingredients do
      after(:create) do |recipe|
        create_list(:recipe_ingredient, 3, recipe: recipe)
      end
    end
  end
end
