# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cuisine_types = %i[italian french salads japanese hamburger bar indian seafood]
cuisines = cuisine_types.each_with_index.map { |name, i| Cuisine.create!(name: name, icon: i) }

rests = []
25.times do
  rests << Restaurant.create!(name: Faker::Name.unique.name,
                              address: Faker::Address.street_address,
                              max_delivery_time_minutes: Random.rand(120),
                              accepts_10bis: [true, false].sample,
                              cuisine: cuisines.sample)
end

1000.times do
  Review.create!(reviewer_name: Faker::Name.unique.name,
                 rating: Random.rand(1..3),
                 comment: Faker::Lorem.paragraph,
                 restaurant: rests.sample)
end