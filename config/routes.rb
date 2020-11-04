Rails.application.routes.draw do

  root 'events#index'

  #Nav links
  get 'home/team', to: 'home#team'
  get 'home/contact', to: 'home#contact'
  get 'home/privacy', to: 'home#privacy'
  get 'home/terms', to: 'home#terms'

  devise_for :users

  resources :users, only: [:show, :edit, :update]

  resources :events

end
