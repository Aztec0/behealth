# frozen_string_literaal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      # Search
      get '/search', to: 'search#search'
      get '/search_by_doctor', to: 'search#search_by_doctor'
      get '/search_by_hospital', to: 'search#search_by_hospital'

      get '/index', to: 'hospitals#index'
      post '/login', to: 'sessions#create'
      post '/forgot', to: 'passwords#forgot'
      post '/reset', to: 'passwords#reset'
      post '/signup', to: 'registrations#signup'
      post '/confirmation', to: 'registrations#confirmation'

      post '/password_reset', to: 'password#reset'
      get '/personal_info', to: 'doctors_cabinet#personal_info'
      get '/professional_info', to: 'doctors_cabinet#professional_info'
      patch '/edit_doctor', to: 'doctors_cabinet#update'

      resources :head_doctors, only: [:index] do
        collection do
          get :canceled_appointments
          post :create_doctor
          post :create_hospital
        end
        member do
          delete :delete
        end
      end

      #Feedbacks for doctors
      get    'doctor/:doctor_id/feedbacks',                  to: 'feedbacks#index'
      post   'doctor/:doctor_id/feedback/create',            to: 'feedbacks#create'

      #Additional information of patient
      get    'patient-account/additional-data',              to: 'additional_info#index'
      post   'patient-account/additional-data/create',       to: 'additional_info#create'
      put    'patient-account/additional-data/update',       to: 'additional_info#update'
      delete 'patient-account/additional-data/destroy',      to: 'additional_info#destroy'

      #Personal information of patient
      get    'patient-account/personal-information',         to: 'personal_info#index'
      post   'patient-account/personal-information/create',  to: 'personal_info#create'
      put    'patient-account/personal-information/update',  to: 'personal_info#update'
      delete 'patient-account/personal-information/destroy', to: 'personal_info#destroy'
    end
  end
end
