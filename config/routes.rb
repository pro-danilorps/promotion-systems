Rails.application.routes.draw do
  
  root 'home#index'
  
  devise_for :users
  resources :users, only: %i[show]
  resources :promotions do
    post 'generate_coupons', on: :member
    get 'search', on: :collection
    resources :coupons, shallow: true, only: [] do
      post 'disable','activate', on: :member
    end
  end

  get 'coupons/search', to: 'coupons#search'
  
  resources :product_categories

end
