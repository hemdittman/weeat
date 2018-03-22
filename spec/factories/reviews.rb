FactoryBot.define do
  factory :review do
    reviewer_name   { Faker::Name.unique.name }
    rating          { Random.rand(1..3) }
    comment         { Faker::Lorem.paragraph }
    association     :restaurant
  end
end
