Rails.application.routes.draw do
  root to: 'posts#index'

  get 'tweets/index'
  get 'tweets/new'
  get 'tweets/show'
  post 'tweets/edit'
  post 'tweets/destroy'
end
