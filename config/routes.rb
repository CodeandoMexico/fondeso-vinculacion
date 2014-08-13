Rails.application.routes.draw do
  devise_for :admins

  match 'profile/', to: 'profiles#handshake', via: [:get, :options]
  match 'profile/submit', to: 'profiles#answers', via: [:post, :options]
  match 'profile/fondos', to: 'profiles#show', via: [:get, :options]

  resources :funds

  root to: "funds#index"
end
