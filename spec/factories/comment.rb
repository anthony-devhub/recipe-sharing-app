FactoryBot.define do
  factory :comment do
    association :user
    association :recipe
    content { "This is a test comment" }
  end
end
