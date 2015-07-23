Rails.application.routes.draw do
  get 'events/stream'
  get 'events' => 'events#index'
  resources :posts
  root 'posts#index'
end
