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
  get 'customers/password/new', to: 'publics/passwords#new'
  get 'customers/password/edit', to: 'publics/passwords#edit'
  patch 'customers/password', to: 'publics/passwords#update'
  put 'customers/password', to: 'publics/passwords#update'
  get 'login' => 'publics/sessions#new', as: :new_customer_session
  post 'login' => 'publics/sessions#create', as: :customer_session
  get 'signup' => 'publics/registrations#new', as: :new_customer_registration
  post 'signup' => 'publics/registrations#create', as: :customer_registration
  get 'password' => 'publics/passwords#new', as: :new_customer_password
  get 'password/edit' => 'publics/passwords#edit', as: :edit_customer_password
  post 'password' => 'publics/passwords#create', as: :customer_password
  #パスワード変更
  get 'password/:id' => 'publics/registrations#edit', as: :edit_customer_registration
  patch "password/:id" => 'publics/registrations#update', as: :update_customer_registration

  end

  root "publics/homes#top"
  get "/about" => "publics/homes#about"
  get "/customers/unsubscribe" => "publics/customers#unsubscribe"
  patch "/customers/withdraw" => "publics/customers#withdraw"
  scope module: :publics do
  get "/customers/unsubscribe" => "customers#unsubscribe"
  patch "/customers/withdraw" => "customers#withdraw"
  get 'password/edit' => 'passwords#edit'
  resources :items, only:[:index, :show]
  get 'genre_items/:id' => "items#genre_items", as: "genre_items"
  get "/orders/complete" => "orders#complete"
  post "/orders/confirm" => "orders#confirm"
  resources :orders, only:[:new, :create, :index, :show]
  delete "/carts/destroy_all" => "carts#destroy_all"
  resources :carts, only:[:index, :update, :destroy, :create]
  resources :customers, only:[:edit, :show, :update]
  resources :addresses, only:[:index, :create, :edit, :destroy, :update]
  end

  namespace :admins do
  get "/" => "homes#top"
  resources :customers, only:[:index, :show, :edit, :update]
  resources :genres, only:[:index, :create, :edit, :update]
  resources :orders, only:[:index, :show, :update]
  resources :items, only:[:index, :new, :create, :show, :edit, :update]
  resources :order_details, only: [:update]
  patch "/orders/:order_id/order_details/:id" => "order_details#update"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end