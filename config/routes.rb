Rails.application.routes.draw do
  devise_for :admins

  match 'profile/', to: 'profiles#handshake', via: [:get, :options]
  match 'profile/submit', to: 'profiles#answers', via: [:post, :options]
  match 'profile/fondos', to: 'profiles#show', via: [:get, :options]
  # match 'fondos', to: 'profiles#index', via: [:options]
  # match 'profile/fondos/categoria/:name', to: 'profiles#category', via: [:get]
  # match 'profile/fondos/categoria/:name/:stage', to: 'profiles#category', via: [:get]

  resources :funds

  root to: "funds#index"
end
