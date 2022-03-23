Rails.application.routes.draw do
  resources :users, only: [:create, :show]

  post '/signup', to: 'users#signup'
  get '/me', to: 'users#show'
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'
end
