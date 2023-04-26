Rails.application.routes.draw do
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

      resources :calendars, only: [:index, :show, :create, :update] do
        member do
          get :events
        end
      end

      resources :doctors, only: [:index, :show, :create, :update]
      resources :patients, only: [:index, :show, :create, :update]
    end
    end
end
