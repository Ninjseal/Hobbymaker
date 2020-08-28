Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: { registrations: "registrations", confirmations: "confirmations", omniauth_callbacks: "omniauth_callbacks" }, path_names: { sign_in: 'login', sign_out: 'logout'}
  ActiveAdmin.routes(self)

  resources :events do
    post :add_to_google_calendar, on: :member
    post :add_to_favorites, on: :member
  end

  get '/profile/:id', to: 'profile#show', as: 'user_profile'
  post '/follow_user/:id', to: 'profile#follow_user', as: 'follow_user'
  post '/unfollow_user/:id', to: 'profile#unfollow_user', as: 'unfollow_user'

  root to: 'home#index'
end
