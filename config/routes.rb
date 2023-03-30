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

      get 'doctors', to: 'doctors#index'
      get 'doctor/:id', to: 'doctors#show'
      get 'doctor/:id/feedbacks', to: 'feedbacks#index'
      post 'doctor/:id/create-feedback', to: 'feedbacks#create'
    end
  end

end
