class ForecastsController < ApplicationController
  def index
  end

  def lookup
    @address = params[:address]
    @location = LocationLookup.new(@address)

    if @location.valid?   
      @zip = @location.zip_code
      forecast_service = WeatherForecast.new(@zip)
      @forecast = forecast_service.fetch
      @from_cache = forecast_service.from_cache?
    end

    render :result
  end
end
