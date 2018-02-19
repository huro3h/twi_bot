Rails.application.routes.draw do
  root to: 'posts#index'
  get 'posts/new'
  get 'posts/show'
  post 'posts/edit'
  post 'posts/create'
  post 'posts/destroy'
end
