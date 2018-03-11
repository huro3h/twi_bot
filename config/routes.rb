Rails.application.routes.draw do
  root to: 'posts#index'
  get 'posts/new'
  get 'posts/show'
  post 'posts/edit'
  post 'posts/create'
  post 'posts/destroy'

  get 'tweets/index'
  get 'tweets/new'
  get 'tweets/show'
  post 'tweets/edit'
  post 'tweets/destroy'
end
