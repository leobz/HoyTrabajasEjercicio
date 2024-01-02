Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :banks
  resources :providers do
    get '/page/:page', action: :index, on: :collection
  end

  scope :charts do
    get 'providers_resgistration_per_month', to: 'charts#providers_resgistration_per_month'
    get 'providers_per_bank', to: 'charts#providers_per_bank'
  end

  get '/dashboard', to: 'home#dashboard'
end
