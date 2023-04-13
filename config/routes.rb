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
