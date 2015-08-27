Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
