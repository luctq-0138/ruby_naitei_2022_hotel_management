Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/rooms", to: "static_pages#rooms"
    get "/about", to: "static_pages#about"
    get "/blog", to: "static_pages#blog"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    post "/save_bookings", to: "bookings#save_booking_session"
    post "/get_room_available", to: "room_types#get_room_available"
    delete "/logout", to: "sessions#destroy"
    resources :password_resets, only: %i(new create edit update)
    resources :account_activations, only: %i(edit)
    resources :bookings, only: %i(create index new destroy)
    resources :room_types,  only: %i(index show)
    resources :users
    namespace :admin do
      root to: "static_pages#index"
      resources :room_types
      resources :bookings
      resources :users
      resources :static_pages
    end
  end
end
