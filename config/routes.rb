Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # swagger
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Login users
  post "/login", to: "auth#login"

  resources :products
  resources :categories
  resources :clients
  resources :purchases


  get :top_earning_products, to: 'analytics#top_earning_products'
  get :top_revenue_products_by_category, to: 'analytics#top_revenue_products_by_category'
  get :purchases, to: 'analytics#purchases'
  get :purchases_by_granularity, to: 'analytics#purchases_by_granularity'

  
  # Defines the root path route ("/")
  # root "posts#index"
end
