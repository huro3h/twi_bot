# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#index'

  resources :tweets, only: %i[index new show create edit destroy]
end
