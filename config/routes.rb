Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: { registrations: "registrations", confirmations: "confirmations" }, path_names: { sign_in: 'login', sign_out: 'logout'}
  root to: 'home#index'
end
