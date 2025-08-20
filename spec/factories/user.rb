FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    sequence(:phone_number) { |n| "+1#{n.to_s.rjust(10, '0')}" }

    trait :with_recipes do
      after(:create) do |user|
        create_list(:recipe, 3, user: user)
      end
    end
  end
end
