Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'products' => 'products#index', as: 'all_products'
  get 'products/:id' => 'products#view', as: 'product_view', id: /\d+/
  get 'products/add/:id' => 'products#add_to_cart', as: 'add_to_cart', id: /\d+/
  get 'products/cart' => 'products#cart', as: 'cart'
  get 'products/checkout' => 'products#checkout', as: 'checkout'
  post 'products/payment' => 'products#payment', as: 'payment'

  get 'customers/register' => 'customers#register', as: 'register'
  post 'customers/create' => 'customers#create', as: 'create_customer'
  get 'customers/login' => 'customers#login', as: 'login'
  get 'customers/logout' => 'customers#logout', as: 'logout'
end
