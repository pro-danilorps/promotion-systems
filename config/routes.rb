Rails.application.routes.draw do
  
  root 'home#index'
  get '/promotions', to: 'promotions#index'
  resources :promotions, only: [:show]

end
