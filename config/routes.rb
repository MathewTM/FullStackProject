Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'products/keyword' => 'products#index', as: 'products'
  get 'products' => 'products#index', as: 'all_products'
end
