Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :appointments, only: [:index, :show, :create, :update] do
        post 'cancel', on: :member
        post 'accept', on: :member
      end
      get 'calendar', to: 'calendar#index'
      end
  end
end
