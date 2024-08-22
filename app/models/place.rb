# app/models/place.rb
class Place < ApplicationRecord
  validates :name, :address, :city, :state, :country, :postal_code, presence: true
  validates :latitude, :longitude, numericality: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, allow_nil: true
  validates :reviews_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
