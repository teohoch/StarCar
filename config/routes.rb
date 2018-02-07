Rails.application.routes.draw do
  resources :cars
  get 'home/index'
  root to: 'home#index'

  devise_for :employees, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
