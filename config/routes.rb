# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      # admin section with additional options
      # Doctors section
      get '/doctors/:id', to: 'doctors#show'
      patch '/doctors/:id/update', to: 'doctors#update'
      post '/doctors/create', to: 'doctors#create'
      delete '/doctors/:id/delete', to: 'doctors#destroy'
      # Hospitals section
      get '/hospitals/:id', to: 'hospitals#show'
      patch '/hospitals/:id/update', to: 'hospitals#update'
      post '/hospitals/create', to: 'hospitals#create'
      delete '/hospitals/:id/delete', to: 'hospitals#delete'
      # Patient section
      get '/patient/:id', to: 'patient#show'
      patch '/patient/:id/update', to: 'patient#update'
      delete '/patient/:id/delete', to: 'patient#delete'
      # end admin section

      get 'tags/index', to: 'tags#index'
      get 'tags/create'
      get 'tags/show'
      patch 'hospital/update/:id', to: 'hospitals#update'

      # Search hospitals and doctors
      get '/search', to: 'search#search'
      get '/search_doctors_by_specialty', to: 'search#search_doctors_by_specialty'
      get '/search_hospitals', to: 'search#search_hospitals'

      get '/index', to: 'hospitals#index'
      post '/login', to: 'sessions#create'
      post '/forgot', to: 'passwords#forgot'
      post '/password-reset', to: 'passwords#reset'
      post '/signup', to: 'registrations#signup'
      post '/confirmation', to: 'registrations#confirmation'

      get 'doctor/main-info', to: 'doctors_cabinet#personal_info'
      get 'doctor/extra-info', to: 'doctors_cabinet#professional_info'
      patch 'doctor/edit', to: 'doctors_cabinet#update'

      # Advanced options for doctors
      get '/list_doctor_by_hospital',                        to: 'doctors#list_doctor_by_hospital'
      get '/staff_appointments',                             to: 'doctors#staff_appointments'
      post '/create_doctor',                                 to: 'doctors#create_doctor'
      delete '/doctors/:id',                                 to: 'doctors#delete_doctor'

      # list all doctors
      get '/doctors',                                        to: 'doctors#index'
      # list all hospitals
      get '/hospitals',                                      to: 'hospitals#index'

      # Chats and messages
      get '/chats',                                          to: 'chats#index'
      post '/chats',                                         to: 'chats#create'
      get '/chats/:id',                                      to: 'chats#show'
      delete '/chats/:id',                                   to: 'chats#delete'
      get '/chats/:chat_id/messages',                        to: 'messages#index'
      post '/chats/:chat_id/messages',                       to: 'messages#create'
      delete '/chats/:chat_id/messages/:id',                 to: 'messages#destroy'

      #Feedbacks for doctors
      get    'doctor/:doctor_id/feedbacks',                  to: 'feedbacks#index'
      post   'doctor/:doctor_id/feedback',                   to: 'feedbacks#create'
      # Feedbacks for doctors
      get    'feedbacks/:type/:id',                          to: 'feedbacks#index'
      post   'feedbacks/:type/:id',                          to: 'feedbacks#create'
      put    'feedbacks/:id',                                to: 'feedbacks#update'
      delete 'feedbacks/:id',                                to: 'feedbacks#destroy'

      # Links for front-end
      get    'patient-account/additional-data',              to: 'additional_info#index'
      post   'patient-account/additional-data',              to: 'additional_info#create'
      put    'patient-account/additional-data',              to: 'additional_info#update'
      delete 'patient-account/additional-data',              to: 'additional_info#destroy'
      get    'patient-account/personal-information',         to: 'personal_info#index'
      post   'patient-account/personal-information',         to: 'personal_info#create'
      put    'patient-account/personal-information',         to: 'personal_info#update'
      delete 'patient-account/personal-information',         to: 'personal_info#destroy'

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

      # Appointments
      get '/appointments',                                   to: 'appointments#index'
      post '/appointments',                                  to: 'appointments#create'
      get '/appointments/:id',                               to: 'appointments#show'
      put '/appointments/:id',                               to: 'appointments#update'
      delete '/appointments/:id',                            to: 'appointments#destroy'
      put '/appointments/:id/cancel',                      to: 'appointments#cancel'
      put '/appointments/:id/accept',                      to: 'appointments#accept'
      get '/appointments/past',                              to: 'appointments#past'
      get '/appointments/upcoming',                          to: 'appointments#upcoming'


      # Chats and messages
      get '/chats',                                          to: 'chats#index'
      post '/chats',                                         to: 'chats#create'
      get '/chats/:id',                                      to: 'chats#show'
      delete '/chats/:id',                                   to: 'chats#delete'
      get '/chats/:chat_id/messages',                        to: 'messages#index'
      post '/chats/:chat_id/messages',                       to: 'messages#create'
      delete '/chats/:chat_id/messages/:id',                 to: 'messages#destroy'


    # Calendar
    get 'calendars', to: 'calendars#index'
    post 'calendars', to: 'calendars#create'
    put 'calendars/:id', to: 'calendars#update'

    # Conclusions
    get '/api/v1/conclusions', to: 'conclusions#index'
    post '/api/v1/conclusions', to: 'conclusions#create'
    get '/api/v1/conclusions/:id', to: 'conclusions#show'
    put '/api/v1/conclusions/:id', to: 'conclusions#update'
    delete '/api/v1/conclusions/:id', to: 'conclusions#destroy'
  end
  namespace :v2 do
    # Search hospitals and doctors
    get '/search', to: 'search#search'
    get '/search_doctors_by_specialty', to: 'search#search_doctors_by_specialty'
    get '/search_hospitals', to: 'search#search_hospitals'

    # Advanced options for doctors
    get '/list_doctor_by_hospital',                        to: 'doctors#list_doctor_by_hospital'
    get '/staff_appointments',                             to: 'doctors#staff_appointments'
    post '/create_doctor',                                 to: 'doctors#create_doctor'
    delete '/delete_doctor/:id',                           to: 'doctors#delete_doctor'

    # list all doctors
    get '/doctors',                                        to: 'doctors#index'
    # list all hospitals
    get '/hospitals',                                      to: 'hospitals#index'

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

      # Appointments
      get '/appointments',                                   to: 'appointments#index'
      post '/appointments',                                  to: 'appointments#create'
      get '/appointments/:id',                               to: 'appointments#show'
      put '/appointments/:id',                               to: 'appointments#update'
      delete '/appointments/:id',                            to: 'appointments#destroy'
      put '/appointments/:id/cancel',                      to: 'appointments#cancel'
      put '/appointments/:id/accept',                      to: 'appointments#accept'
      get '/appointments/past',                              to: 'appointments#past'
      get '/appointments/upcoming',                          to: 'appointments#upcoming'


      # Calendar
      get '/calendars',                                      to: 'calendars#index'
      post '/calendars',                                     to: 'calendars#create'
      put '/calendars/:id',                                  to: 'calendars#update'


      # Chats and messages
      get '/chats',                                          to: 'chats#index'
      post '/chats',                                         to: 'chats#create'
      get '/chats/:id',                                      to: 'chats#show'
      delete '/chats/:id',                                   to: 'chats#delete'
      get '/chats/:chat_id/messages',                        to: 'messages#index'
      post '/chats/:chat_id/messages',                       to: 'messages#create'
      delete '/chats/:chat_id/messages/:id',                 to: 'messages#destroy'


      # Conclusions
      get 'conclusions',                                     to: 'conclusions#index'
      post '/conclusions',                                   to: 'conclusions#create'
      get '/conclusions/:id',                                to: 'conclusions#show'
      put '/conclusions/:id',                                to: 'conclusions#update'
      delete '/conclusions/:id',                             to: 'messages#destroy'

      # Feedbacks
      get    'feedbacks/:type/:id',                          to: 'feedbacks#index'
      post   'feedbacks/:type/:id',                          to: 'feedbacks#create'
      put    'feedbacks/:id',                                to: 'feedbacks#update'
      delete 'feedbacks/:id',                                to: 'feedbacks#destroy'
    end
  end
end
