Rails.application.routes.draw do

  if Rails.env.production?
    devise_for :admins, controllers: { registrations: "registrations" }
  else
    devise_for :admins
  end

  match 'profile/submit', to: 'profiles#answers', via: [:post, :options]
  match 'profile/:category_name', to: 'profiles#show', via: [:post, :options]

  resources :funds

  root to: "funds#index"
end
