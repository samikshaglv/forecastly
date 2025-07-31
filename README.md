# 🌤️ Weather Forecast Lookup – Ruby on Rails 8 + Hotwire

This is a production-quality Rails 8 application that accepts a **user-provided address**, extracts the **zip code** using the `geocoder` gem, and retrieves **weather forecast data** (current temperature, highs/lows, and conditions) using the **OpenWeatherMap API**.

Results are **cached for 30 minutes** per zip code using Rails' built-in caching, and indicators are shown when a result is served from cache.

---

## ⚙️ Tech Stack

- Ruby on Rails 8 (API & UI)
- RSpec (Testing)
- Geocoder (Address → Zip)
- OpenWeatherMap API
- Caching with `Rails.cache`
- Bootstrap (basic styling)

---

## 🚀 Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/samikshaglv/weather_forecast_app.git
cd weather_forecast_app

2. Install dependencies
bundle install
yarn install --check-files

3. Set up credentials
You will need to store your OpenWeatherMap API key in Rails credentials.
EDITOR="code --wait" bin/rails credentials:edit

Then add:
open_weather:
  api_key: your_actual_api_key_here

5. Start the Rails server
bin/dev

Visit: http://localhost:3000

6. Running Tests
This app uses RSpec for unit testing.
bundle exec rspec

The test suite includes:
Unit tests for weather forecast service
Zip code lookup tests using the Geocoder stubbed results
Caching validation test

6. weather forecast Api Flow
Visit the homepage
Enter a valid address (e.g., 1600 Amphitheatre Parkway, Mountain View, CA)
View the current weather forecast and details
If the same zip code is searched again within 30 minutes, it will serve from cache

7. Design Notes
Service classes are separated into:
LocationLookup: Handles address geocoding and zip extraction
WeatherForecast: Fetches forecast data and handles caching
Tests are isolated with clear mocking and stubbing strategies

```
8. Sample Output

City: Mountain View
Zip: 94043
Temperature: 21.5 °C
High: 23.0 °C
Low: 18.0 °C
Description: Clear sky
(From Cache)

```
File Structure Overview

app/
├── controllers/forecasts_controller.rb
├── services/
│   ├── location_lookup.rb
│   └── weather_forecast.rb
├── views/
│   └── forecasts/
│       ├── index.html.erb
│       └── result.html.erb
config/
├── credentials.yml.enc (keep secret)
├── routes.rb
spec/
├── services/location_lookup_spec.rb
├── services/weather_forecast_spec.rb

```
credentials.yml.enc is not committed
master.key is not included in version control (add to .gitignore)



