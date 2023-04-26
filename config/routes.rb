# frozen_string_literaal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get '/search', to: 'search#search'
      get '/index', to: 'hospitals#index'
      post '/login', to: 'sessions#create'
      post '/forgot', to: 'passwords#forgot'
      post '/reset', to: 'passwords#reset'
      post '/signup', to: 'registrations#signup'
      post '/confirmation', to: 'registrations#confirmation'

      post '/password-reset', to: 'password#reset'
      get 'doctor/main-info', to: 'doctors_cabinet#personal_info'
      get 'doctor/extra-info', to: 'doctors_cabinet#professional_info'
      patch 'doctor/edit', to: 'doctors_cabinet#update'

      resources :head_doctors, path: 'head-doctors', only: [:index] do
        collection do
          get 'canceled-appointments', action: :canceled_appointments, as: :canceled_appointments
          post 'create-doctor', action: :create_doctor, as: :create_doctor
          post 'create-hospital', action: :create_hospital, as: :create_hospital
        end
        member do
          delete :delete
        end
      end

      # Feedbacks for doctors
      get    'doctor/:doctor_id/feedbacks',                  to: 'feedbacks#index'
      post   'doctor/:doctor_id/feedback',                   to: 'feedbacks#create'

      # Additional information of patient
      get    'patient/extra-info',                           to: 'additional_info#index'
      post   'patient/extra-info',                           to: 'additional_info#create'
      put    'patient/extra-info',                           to: 'additional_info#update'
      delete 'patient/extra-info',                           to: 'additional_info#destroy'

      # Personal information of patient
      get    'patient/main-info',                            to: 'personal_info#index'
      post   'patient/main-info',                            to: 'personal_info#create'
      put    'patient/main-info',                            to: 'personal_info#update'
      delete 'patient/main-info',                            to: 'personal_info#destroy'
    end

    namespace :v2 do
      # Additional information of patient
      get    'patient/extra-info',                           to: 'additional_info#index'

      # Personal information of patient
      get    'patient/main-info',                            to: 'personal_info#index'
      put    'patient/main-info',                            to: 'personal_info#update'

      # Address of patient
      post   'patient/address',                              to: 'patient_address#create'
      put    'patient/address',                              to: 'patient_address#update'
      delete 'patient/address',                              to: 'patient_address#destroy'

      # Document of patient
      post   'patient/document',                              to: 'patient_document#create'
      put    'patient/document',                              to: 'patient_document#update'
      delete 'patient/document',                              to: 'patient_document#destroy'

      # Workplace of patient
      post   'patient/work',                                  to: 'patient_work#create'
      put    'patient/work',                                  to: 'patient_work#update'
      delete 'patient/work',                                  to: 'patient_work#destroy'
    end
  end
end
