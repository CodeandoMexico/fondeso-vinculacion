Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  if Rails.env.production?
    devise_for :admins, controllers: { registrations: "admins/registrations", sessions: 'admins/sessions' }
  else
    devise_for :admins, controllers: { sessions: 'admins/sessions' }
  end

  devise_scope :user do
    get "/" => "users/sessions#new"
  end

  match 'profile/submit', to: 'profiles#answers', via: [:post, :options]
  # match 'profile/:category_name', to: 'profiles#show', via: [:post, :options]
  match 'profile/', to: 'profiles#create', via: [:post, :options]
  match 'profile/', to: 'profiles#destroy', via: [:delete]

  resources :profiles, only: [:index]
  resources :funds
  resources :questionary, only: :index

  get "*path" => "questionary#index"
  root to: "users/sessions#new"
end
