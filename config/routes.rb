Rails.application.routes.draw do
  root to: "organizations#index"

  resources :organizations, only: [:index, :show]
end
