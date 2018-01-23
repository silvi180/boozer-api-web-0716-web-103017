Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :ingredients
      resources :cocktails
      resources :users
      resources :saved_drinks
      post '/auth', to: 'authorizations#create'
      get '/current_user', to: 'authorizations#show'
    end
  end
end
