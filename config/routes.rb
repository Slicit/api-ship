Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :shipments, only: [:index, :show, :create, :update, :destroy]
    end
  end
end

