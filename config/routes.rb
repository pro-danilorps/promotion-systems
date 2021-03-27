Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'
  
  resources :promotions do
    post 'generate_coupons', on: :member
    get 'search_promotions', on: :collection
    get 'search_coupons', on: :collection
  end
  
  resources :product_categories

  resources :coupons, only: [] do
    post 'disable','activate', on: :member
  end

end
