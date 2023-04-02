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
      resources :head_doctors, only: [:index] do
        collection do
          get :canceled_appointments
          post :create_doctor
          post :create_hospital
        end

        member do
          delete :delete_doctor
        end
      end
    end
  end
end
