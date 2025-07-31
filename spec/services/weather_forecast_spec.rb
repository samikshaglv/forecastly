# spec/services/weather_forecast_spec.rb
require 'rails_helper'

RSpec.describe WeatherForecast do
  let(:zip_code) { "94043" }
  let(:cache_key) { "weather_forecast_#{zip_code}" }

  let(:fake_api_response) do
    {
      "main" => {
        "temp" => 19.89,
        "temp_min" => 18.2,
        "temp_max" => 22.4
      },
      "weather" => [
        { "description" => "clear sky" }
      ],
      "name" => "Mountain View"
    }.to_json
  end

  before do
    stub_request(:get, /api.openweathermap.org/).to_return(
      status: 200,
      body: fake_api_response,
      headers: { 'Content-Type' => 'application/json' }
    )
    Rails.cache.clear
  end

  it "fetches and returns weather data" do
    forecast = described_class.new(zip_code).fetch

    expect(forecast[:temperature]).to eq(19.89)
    expect(forecast[:temp_min]).to eq(18.2)
    expect(forecast[:temp_max]).to eq(22.4)
    expect(forecast[:description]).to eq("clear sky")
  end

  it "caches the result" do
    service = described_class.new(zip_code)
    service.fetch

    expect(Rails.cache.exist?(cache_key)).to eq(true)
  end
end
