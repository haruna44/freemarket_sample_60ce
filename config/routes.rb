Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
    }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'creditcards', to: 'users/registrations#new_creditcard'
    post 'creditcards', to: 'users/registrations#create_creditcard'
  end
  root "products#index"
  resources :users, only: [:show, :edit, :update]do
    member do
      get 'profile'
      patch 'profile_update'
      get 'logout'
    end
    collection do
      get 'ready'
    end
  end
  namespace :products do
    resources :searches, only: [:index,:show]
    
  end
  
  resources :products do
    member do
      post 'purchase'
      get 'purchased'
      get 'buy'
      get 'reserve'
      patch 'reserved'
      patch 'reserve_cancel'
    end

    collection do
      get 'search_child', defaults: { format: 'json' }
      get 'search_grandchild', defaults: { format: 'json' }
    end

    resources :comments,only:[:create,:destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :registration, only: [:index]
  resources :cards, only: [:show]
  resources :categories, only: [:index, :show]
end
