Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :passwords, param: :token

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :v1 do
    post '/signup', to: 'registration#create'
    post '/login', to: 'sessions#create'
    resource :passwords, param: :token
  end
end
