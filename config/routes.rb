Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'authorization_code', controller: 'users/omniauth_callbacks', action: :authorization_code
  end

  resources :photos, only: [:destroy, :new, :create]
end
