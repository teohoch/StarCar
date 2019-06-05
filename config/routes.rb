Rails.application.routes.draw do
  resources :acquisitions
  resources :quotes
  resources :sales
  resources :clients
  resources :cars
  resources :reservations do
    member do
      get 'cancel'
      get 'sell'
      get 'reinstate'
    end
  end
  get 'home/index'
  root to: 'home#index'

  devise_for :employees, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
