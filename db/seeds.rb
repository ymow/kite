require 'faker'

# Define the categories based on the suggested list
CATEGORIES = [
  "Restaurants & Dining", "Shopping & Retail", "Health & Wellness",
  "Entertainment & Leisure", "Education", "Financial Services",
  "Transportation", "Public Services", "Tourism & Travel",
  "Real Estate", "Outdoor & Recreation", "Religious Institutions",
  "Technology & IT", "Professional Services", "Automotive",
  "Food & Beverage Production", "Pet Services", "Community & Social Services",
  "Construction & Contractors", "Arts & Culture", "Emergency Services",
  "Agriculture & Farming", "Beauty & Personal Care", "Sports & Fitness",
  "Environmental & Green Services", "Manufacturing & Industrial",
  "Media & Communications", "Events & Conferences"
]

# Helper method to generate random hours of operation
def random_hours
  opening_hour = rand(6..11) # Random opening hour between 6 AM and 11 AM
  closing_hour = rand(18..23) # Random closing hour between 6 PM and 11 PM
  "#{opening_hour}:00 AM - #{closing_hour}:00 PM"
end

# Create 100 random places
100.times do
  Place.create!(
    name: Faker::Company.name,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    postal_code: Faker::Address.zip_code,
    latitude: rand(25.0306..25.0392),  # Random latitude within a specific range
    longitude: rand(121.5580..121.5762),  # Random longitude within a specific range
    category: CATEGORIES.sample,  # Randomly select a category
    description: Faker::Lorem.paragraph,
    phone_number: Faker::PhoneNumber.phone_number,
    website: Faker::Internet.url,
    hours_of_operation: {
      monday: random_hours,
      tuesday: random_hours,
      wednesday: random_hours,
      thursday: random_hours,
      friday: random_hours,
      saturday: random_hours,
      sunday: ["Closed", random_hours].sample  # Randomly either closed or open with random hours
    },
    rating: rand(1.0..5.0).round(1),  # More realistic rating
    reviews_count: rand(0..100)  # Random number of reviews
  )
end
