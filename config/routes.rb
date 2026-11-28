# frozen_string_literal: true

Rails.application.routes.draw do
  root "books#index"

  resources :books

  get 'up' => 'rails/health#show', as: :rails_health_check
end
