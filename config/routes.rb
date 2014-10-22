Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords' }

  if Rails.env.production?
    devise_for :admins, controllers: { registrations: "admins/registrations", sessions: 'admins/sessions' }
  else
    devise_for :admins, controllers: { sessions: 'admins/sessions' }
  end

  match 'profile/submit', to: 'profiles#answers', via: [:post, :options]
  match 'profile/', to: 'profiles#create', via: [:post, :options]
  match 'profile/', to: 'profiles#destroy', via: [:delete]
  match 'terms-and-conditions/', to: 'application#terms_and_conditions', via: :get
  match 'privacy/', to: 'application#privacy', via: :get

  namespace :dashboard do
    resources :users, only: :index
  end

  resources :profiles, only: [:index]
  resources :funds
  resources :questionary, only: :index

  get "*path" => "questionary#index"
  root to: "application#landing"
end
