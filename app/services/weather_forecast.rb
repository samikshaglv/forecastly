# app/services/weather_forecast.rb
require 'net/http'
require 'json'

class WeatherForecast
  CACHE_EXPIRY = 30.minutes

  def initialize(zip)
    @zip = zip
    @api_key = Rails.application.credentials.dig(:open_weather, :api_key) || "fake_key"
  end

  def fetch
    Rails.cache.fetch(cache_key, expires_in: CACHE_EXPIRY) do
      get_forecast
    end
  end

  def from_cache?
    Rails.cache.exist?(cache_key)
  end

  private

  def cache_key
    "weather_forecast_#{@zip}"
  end

  def get_forecast
    uri = URI("https://api.openweathermap.org/data/2.5/weather?zip=#{@zip}&units=metric&appid=#{@api_key}")
    response = Net::HTTP.get_response(uri)

    return { error: "API error" } unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    {
      temperature: data.dig("main", "temp"),
      temp_min: data.dig("main", "temp_min"),
      temp_max: data.dig("main", "temp_max"),
      description: data.dig("weather", 0, "description"),
      location: data["name"]
    }
  end
end
