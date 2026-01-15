# frozen_string_literal: true

Rails.application.routes.draw do
  root 'books#index'

  resources :books
end
