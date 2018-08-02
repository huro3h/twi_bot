# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :posts
    resources :tweets

    root to: 'posts#index'
  end

  root to: 'posts#index'
  resources :tweets
end
