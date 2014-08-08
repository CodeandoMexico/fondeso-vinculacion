Rails.application.routes.draw do
  namespace :api do
    match '/', to: 'funds#handshake', via: [:get, :options]
    match 'submit', to: 'funds#answers', via: [:post, :options]
    match 'fondos', to: 'funds#show', via: [:get, :options]
    # match 'fondos', to: 'funds#index', via: [:options]
    match 'fondos/categoria/:name', to: 'funds#category', via: [:get]
    match 'fondos/categoria/:name/:stage', to: 'funds#category', via: [:get]
  end

  resources :funds
end
