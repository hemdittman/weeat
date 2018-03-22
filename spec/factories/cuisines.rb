FactoryBot.define do
  factory :cuisine do
    name  { Faker::Name.unique.name }
  end
end
