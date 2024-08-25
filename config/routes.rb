Rails.application.routes.draw do
  root "pages#index"
  get "about", to: "pages#about"
  get "services", to: "pages#services"
  get "pricing", to: "pages#pricing"
  get "roadmap", to: "pages#roadmap"
  get "contact", to: "pages#contact"
  get "blog", to: "pages#blog"

  get 'chats', to: 'chats#index'
  post 'chats/send_message', to: 'chats#send_message'

  namespace :admin do
    resources :places
    root to: "dashboards#index"    # Add more admin routes here
  end
end
