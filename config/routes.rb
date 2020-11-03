Rails.application.routes.draw do
  root 'events#index'

  get 'events/index', to: 'events#home'
  get 'events/secret', to: 'events#secret'
  get 'events/team', to: 'events#team'
  get 'events/contact', to: 'events#contact'
  #get 'events/privacy', to: 'events#privacy'
  #get 'events/terms', to: 'events#terms'



  devise_for :users

end
