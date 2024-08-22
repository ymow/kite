# db/seeds.rb
require 'faker'

10.times do
  Place.create!(
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip_code,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    category: Faker::Commerce.department,
    description: Faker::Lorem.paragraph,
    phone_number: Faker::PhoneNumber.phone_number,
    website: Faker::Internet.url,
    hours_of_operation: {
      monday: "9:00 AM - 5:00 PM",
      tuesday: "9:00 AM - 5:00 PM",
      wednesday: "9:00 AM - 5:00 PM",
      thursday: "9:00 AM - 5:00 PM",
      friday: "9:00 AM - 5:00 PM",
      saturday: "10:00 AM - 4:00 PM",
      sunday: "Closed"
    },
    rating: rand(1.0..5.0).round(1),
    reviews_count: rand(0..100)
  )
end
