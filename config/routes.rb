Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :promotions do
    member do
      post 'generate_coupons'
      post 'approve'
    end
    get 'search', on: :collection
    resources :coupons, shallow: true, only: [] do
      post 'disable','activate', on: :member
    end
  end

  get 'coupons/search', to: 'coupons#search'
  
  
  resources :users, only: %i[show]
  resources :product_categories

  namespace :api, constraints: -> (req) {req.format == :json} do
    namespace :v1 do
      resources :coupons, only: %i[show], param: :code
    end
  end
end
