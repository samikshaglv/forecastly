# app/services/location_lookup.rb
class LocationLookup
  attr_reader :address, :location

  def initialize(address)
    @address = address
    @location = Geocoder.search(address).first
  end

  def zip_code
    location&.postal_code
  end

  def city
    location&.city
  end

  def state
    location&.state
  end

  def country
    location&.country
  end

  def coordinates
    location&.coordinates
  end

  def valid?
    location.present?
  end
end
