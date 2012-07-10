Euclid::Application.routes.draw do
  # Transactions
  get "transactions/cancel"
  
  # Listings
  get "listings/cancel"

  # Availabilities
  get "availabilities/search"
  get "availabilities/results"  
  get "availabilities/rent"

  # Account
  get "account/login"
  get "account/logout"
  get "account/index"

  # Spots
  get "spots/yours"

  # Home
  get "home/index"
  get "home/dashboard"
  
  # Admin
  get "admin/index"

  # Requests
  get "requests/search"
  get "requests/results"
  get "requests/fulfill"
  get "requests/rent"
  get "requests/error"

  # Resources
  resources :transactions
  resources :requests
  resources :listings
  resources :spots
  resources :buildings
  resources :users
  resources :availabilities

  # Default page
  root to: "home#splash"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
