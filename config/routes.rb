Rails.application.routes.draw do
  # Home page route
  root "index_home#index"
  
  # Devise routes for user authentication
  devise_for :users

  # Cart routes
  resource :cart, only: [:show] do
    # POST method to add an item to the cart
    post 'add_item/:item_id', to: 'carts#add_item', as: 'add_item'
    delete 'remove_item', to: 'carts#remove_item', as: 'remove_item'
  end



  # CartItems routes to handle item-specific actions in the cart
  resources :cart_items, only: [:create, :destroy, :increase] do
    member do
      patch :increase
      patch :decrease
    end
  end

  # Admin namespace routes
  namespace :admin do
    resources :items
    get 'dashboard', to: 'home#index'
    resources :user_list
  end

  # User routes for profile management
  resource :user, only: [:show, :edit, :update]

  # Static pages routes
  get 'about_us', to: 'pages#about_us'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Custom routes for admin management
  get 'admin/pending/index'
  get 'admin/home/index'

  # IndexHome routes
  get 'index_home/index'
end
