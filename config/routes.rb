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
  match 'terminos-y-condiciones/', to: 'application#terms_and_conditions', via: :get, as: 'terms_and_conditions'
  match 'privacidad/', to: 'application#privacy', via: :get, as: 'privacy'

  match 'questionary/', to: 'questionary#save', via: :post

  namespace :dashboard do
    resources :users, only: :index
  end

  resources :profiles, only: [:index], path: 'perfiles'
  resources :funds, path: 'programas'
  resources :questionary, only: :index, path: 'cuestionario'

  get "*path" => "questionary#index"
  root to: "application#landing"
end
