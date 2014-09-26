Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  if Rails.env.production?
    devise_for :admins, controllers: { registrations: "admins/registrations", sessions: 'admins/sessions' }
  else
    devise_for :admins, controllers: { sessions: 'admins/sessions' }
  end

  # devise_scope :admin do
  #   get "/" => "admins/sessions#new"
  # end

  devise_scope :user do
    get "/" => "users/sessions#new"
  end

  devise_scope :user do
    get "users/current" => "users/sessions#show_current_user"
  end

  match 'profile/submit', to: 'profiles#answers', via: [:post, :options]
  match 'profile/:category_name', to: 'profiles#show', via: [:post, :options]
  # match 'users/current', to: 'users/sessions#show_current_user', via: [:get]

  resources :funds

  # root to: 'funds#index'
  # root to: "admins/sessions#new"
  root to: "users/sessions#new"
end
