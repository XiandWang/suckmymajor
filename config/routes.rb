Rails.application.routes.draw do
  get 'notifications/index'

  get 'comments/new'

  get 'comments/create'

  get 'comments/destroy'

  get 'comments/show'

  get 'majors/show'

  get 'majors/index'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root to: "pages#home"
  get 'pages/help'
  get 'pages/about'
  get 'signup' => 'users#new'

  resources :users do 
    member do
      get :majors
    end
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :bets, only: [:create, :destroy, :show] do
    member do
      get :like, :dislike
    end
    resources :comments
  end

  resources :majors, only: [:show, :index] do
    member do
      get :students
    end
  end

  resources :user_major_relationships, only: [:create, :destroy]

  resources :notifications, only: [:index]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
