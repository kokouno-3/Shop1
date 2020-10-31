Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  root "publics/homes#top"
  get "/about" => "public/homes#about"
  resources :customers, only:[:edit, :show, :update]
  get "/customers/unsubscribe" => "public/customers#unsubscribe"
  patch "/customers/withdraw" => "public/customers#withdraw"
  resources :items, only:[:index, :show]
  resources :carts, only:[:index, :update, :destroy, :create]
  delete "/cart_items/destroy_all" => "public/cart_items/destroy_all"
  resources :orders, only:[:new, :create, :index, :show]
  post "/orders/confirm" => "public/orders#confirm"
  get "/orders/complete" => "public/orders#complete"
  resources :addresses, only:[:index, :create, :edit, :destroy, :update]

  namespace :admins do
  get "/" => "homes#top"
  resources :customers, only:[:index, :show, :edit, :update]
  resources :genres, only:[:index, :create, :edit, :update]
  resources :orders, only:[:index, :show, :update]
  resources :items, only:[:index, :new, :create, :show, :edit, :update]
  patch "/orders/:order_id/order_details/:id" => "order_details#update"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end





 #get 'order_details/update'
  #get 'items/index'
  #get 'items/new'
  #get 'items/create'
  #get 'items/show'
  #get 'items/edit'
  #get 'items/update'
  #get 'orders/index'
  #get 'orders/show'
  #get 'genres/index'
  #get 'genres/create'
  #get 'genres/edit'
  #get 'genres/update'
  #get 'customers/index'
  #get 'customers/show'
  #get 'customers/edit'
  #get 'customers/update'
  #get 'homes/top'
  #get 'homes/about'
  #get 'addresses/index'
  #get 'addresses/create'
  #get 'addresses/edit'
  #get 'addresses/destroy'
  #get 'addresses/update'
  #get 'orders/new'
  #get 'orders/comfirm'
  #get 'orders/complete'
  #get 'orders/create'
  #get 'orders/index'
  #get 'orders/show'
  #get 'carts/index'
  #get 'carts/update'
  #get 'carts/destroy'
  #get 'carts/destroy_all'
  #get 'carts/create'
  #get 'items/index'
  #get 'items/show'