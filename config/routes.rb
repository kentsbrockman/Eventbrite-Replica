Rails.application.routes.draw do

  root 'events#index'

  #Nav links
  get 'home/team', to: 'home#team'
  get 'home/contact', to: 'home#contact'
  get 'home/privacy', to: 'home#privacy'
  get 'home/terms', to: 'home#terms'
  get 'home/flatly', to: 'home#flatly'
  get 'home/basics', to: 'home#basics'


  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    resources :avatars, only: [:create]
  end

  resources :events do 
    resources :attendances
    resources :event_pictures, only: [:create]
  end

  namespace :admin do
    root 'admin#index'
  end

end
