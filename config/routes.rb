Rails.application.routes.draw do
  root 'events#index'
  get 'events/index', to: 'events#index'

  get 'events/secret'
  devise_for :users

end
