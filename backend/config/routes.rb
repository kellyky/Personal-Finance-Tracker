Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :v1 do
    post '/signup', to: 'registration#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :passwords, param: :token
    resources :registrations, only: %i[create]
  end
end
