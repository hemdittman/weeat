FactoryBot.define do
  factory :restaurant do
    name                      { Faker::Name.unique.name }
    address                   { Faker::Address.street_address }
    max_delivery_time_minutes Random.rand(90)
    accepts_10bis             [true, false].sample
    association               :cuisine
  end
end
