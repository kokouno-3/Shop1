Rails.application.routes.draw do
  devise_for :admins, skip: :all
  devise_scope :admin do
  get 'admins/sign_in',to: 'admins/sessions#new'
  post 'admins/sign_in',to: 'admins/sessions#create'
  delete 'admins/sign_out',to: 'admins/sessions#destroy'
  end

  devise_for :customers, skip: :all
  devise_scope :customer do
  get 'customers/sign_up', to: 'publics/registrations#new'
  post 'customers/sign_up', to: 'publics/registrations#create'
  patch 'customers', to: 'publics/registrations#update'
  put 'customers', to: 'publics/registrations#update'
  delete 'customers', to: 'publics/registrations#update'
  get 'customers/sign_in',to: 'publics/sessions#new'
  post 'customers/sign_in',to: 'publics/sessions#create'
  delete 'customers/sign_out',to: 'publics/sessions#destroy'
  get 'customers/password/edit', to: 'devise/passwords#edit'
  patch '/customers/password', to: 'devise/passwords#update'
  put '/customers/password', to: 'devise/passwords#update'
  end

  root "publics/homes#top"
  get "/about" => "publics/homes#about"

  scope module: :publics do
  resources :items, only:[:index, :show]
  get 'genre_items/:id' => "items#genre_items", as: "genre_items"
  get "/orders/complete" => "orders#complete"
  post "/orders/comfirm" => "orders#comfirm"
  resources :orders, only:[:new, :create, :index, :show]
  delete "/carts/destroy_all" => "carts#destroy_all"
  resources :carts, only:[:index, :update, :destroy, :create]
  resources :customers, only:[:edit, :show, :update] 
  resources :addresses, only:[:index, :create, :edit, :destroy, :update]

  end

  get "/customers/unsubscribe" => "publics/customers#unsubscribe"
  patch "/customers/withdraw" => "publics/customers#withdraw"

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