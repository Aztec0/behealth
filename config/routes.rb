Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get '/index', to: 'hospitals#index'
      get 'hospitals/create'
      post '/login', to: 'sessions#create'
      post '/forgot', to: 'passwords#forgot'
      post 'password/reset', to: 'password#reset'
      resources :head_doctor, only: %i[create destroy] do
        get 'canceled_appointments', on: :collection
      end
    end
  end
end
