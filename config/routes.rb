Rails.application.routes.draw do
  get 'home/index'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  # All Routes
  resource :users, except: %i[index update edit], path: "", path_names: {new: :register, show: :profile}
  resource :sessions, only: %i[new create destroy],path: "auth", path_names: {new: :login, destroy: :logout}
end
