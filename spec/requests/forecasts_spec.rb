require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/forecasts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /lookup" do
    it "returns http success" do
      get "/forecasts/lookup"
      expect(response).to have_http_status(:success)
    end
  end

end
