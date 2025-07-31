Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  post "/lookup", to: "forecasts#lookup", as: :lookup
  # Defines the root path route ("/")
  root "forecasts#index"
end
