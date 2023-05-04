# frozen_string_literal: true
require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :appointments, only: [:index, :show, :create, :update] do
        member do
          post :cancel
          post :accept
        end
      end

      # Search hospitals and doctors
      get '/search', to: 'search#search'
      get '/search_doctors_by_specialty', to: 'search#search_doctors_by_specialty'
      get '/search_hospitals', to: 'search#search_hospitals'

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

      # Advanced options for doctors
      get '/list_doctor_by_hospital',                        to: 'doctors#list_doctor_by_hospital'
      get '/staff_appointments',                             to: 'doctors#appointments'
      post '/create_doctor',                                 to: 'doctors#create_doctor'
      post '/create_hospital',                               to: 'doctors#create_hospital'
      delete '/doctors/:id',                                 to: 'doctors#delete'

      # list all doctors
      get '/doctors',                                        to: 'doctors#index'
      # list all hospitals
      get '/hospitals',                                      to: 'hospitals#index'

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
    
    resources :calendars, only: [:index, :show, :create, :update] do
        member do
          get :events
        end
      end

      resources :doctors, only: [:index, :show, :create, :update]
      resources :patients, only: [:index, :show, :create, :update]

    namespace :v2 do
      # Advanced options for doctors
      get '/list_doctor_by_hospital',                        to: 'doctors#list_doctor_by_hospital'
      get '/staff_appointments',                             to: 'doctors#appointments'
      post '/create_doctor',                                 to: 'doctors#create_doctor'
      post '/create_hospital',                               to: 'doctors#create_hospital'
      delete '/doctors/:id',                                 to: 'doctors#delete'

      # list all doctors
      get '/doctors',                                        to: 'doctors#index'
      # list all hospitals
      get '/hospitals',                                      to: 'hospitals#index'

      #Additional information of patient
      get    'patient/extra-info',                           to: 'additional_info#index'

      #Personal information of patient
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
