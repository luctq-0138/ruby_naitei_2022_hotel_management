Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/rooms", to: "static_pages#rooms"
    get "/about", to: "static_pages#about"
    get "/blog", to: "static_pages#blog"
    get "/contact", to: "static_pages#contact"
    # get "/signup", to: "users#new"
    # get "/login", to: "sessions#new"
    # post "/login", to: "sessions#create"
    # delete "/logout", to: "sessions#destroy"
    post "/save_bookings", to: "bookings#save_booking_session"
    get "/get_room_available", to: "room_types#get_room_available"
    post "/search", to: "room_types#search"
    resources :password_resets, only: %i(new create edit update)
    resources :account_activations, only: %i(edit)
    resources :reviews, only: %i(create update)
    resources :bookings, only: %i(create index new destroy)
    resources :room_types,  only: %i(index show)
    devise_for :users
    resources :users
    namespace :admin do
      root to: "static_pages#index"
      resources :room_types do
        collection {get :export}
      end
      resources :bookings
       resources :users do
        resources :bookings
      end
      resources :static_pages
    end
  end
end
