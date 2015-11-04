Rails.application.routes.draw do
  get 'notifications/index'




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
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :bets, only: [:create, :destroy, :show] do
    member do
      get :like, :dislike
    end
  end

  resources :majors, only: [:show, :index] do
    member do
      get :students
    end
  end

  resources :user_major_relationships, only: [:create, :destroy]

  resources :notifications, only: [:index, :destroy] do
    collection do
      post :clear
    end
  end
  resources :likes, only: [:create, :destroy]
end
