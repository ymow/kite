Rails.application.routes.draw do
  root "places#index"
  get "about", to: "places#about"
  get "services", to: "places#services"
  get "pricing", to: "places#pricing"
  get "roadmap", to: "places#roadmap"
  get "contact", to: "places#contact"
  get "blog", to: "places#blog"

  namespace :admin do
    resources :places
    root to: "dashboards#index"    # Add more admin routes here
  end
end
