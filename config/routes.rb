Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: { registrations: "registrations", confirmations: "confirmations", omniauth_callbacks: "omniauth_callbacks" }, path_names: { sign_in: 'login', sign_out: 'logout'}
  ActiveAdmin.routes(self)

  resources :events do
    post :add_to_google_calendar, on: :member
    post :add_to_favorites, on: :member
    post :join, on: :member
    post :withdraw, on: :member
  end

  resources :interests, only: :show do
    post :subscribe, on: :member
    post :unsubscribe, on: :member
  end

  resources :polls do
    post :vote, on: :member
  end

  resources :posts do
    post :add_to_favorites, on: :member
    post :add_comment, on: :member
  end

  post '/update_comment/:id', to: 'posts#update_comment', as: 'update_comment'
  delete '/comment/:id', to: 'posts#delete_comment', as: 'comment'

  get '/report_comment/:id', to: 'posts#report_comment', as: 'report_comment'
  get '/report_post/:id', to: 'posts#report_post', as: 'report_post'
  get '/report_poll/:id', to: 'polls#report_poll', as: 'report_poll'
  get '/report_event/:id', to: 'events#report_event', as: 'report_event'
  get '/report_user/:id', to: 'profile#report_user', as: 'report_user'
  post '/report_item/:id', to: 'application#report_item', as: 'report_item'

  get '/profile/:id', to: 'profile#show', as: 'user_profile'
  get '/edit_my_profile', :to => 'profile#edit', :as => 'edit_profile'
  post '/update_my_profile', :to => 'profile#update', :as => 'update_profile'
  get 'profile/:id/favorite_posts', :to => 'profile#favorite_posts', :as => 'favorite_posts'
  get 'profile/:id/favorite_events', :to => 'profile#favorite_events', :as => 'favorite_events'


  post '/follow_user/:id', to: 'profile#follow_user', as: 'follow_user'
  post '/unfollow_user/:id', to: 'profile#unfollow_user', as: 'unfollow_user'

  post '/regions/:id', to: 'application#fetch_regions', as: 'fetch_regions'
  post '/cities/:id', to: 'application#fetch_cities', as: 'fetch_cities'

  get '/admin/send-report-notification/:id' , to: 'admin/reports#report_notification', as: 'report_notification'
  get '/admin/send-mail-report/:id', to: 'admin/reports#mail', as: 'mail'
  post '/admin/reports/:id/reject', to: 'admin/reports#reject', as: 'reject_report'

  get '/search', :to => 'search#index', :as => 'search'

  root to: 'home#index'
end
