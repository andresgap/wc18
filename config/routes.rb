Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'authentication' }

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    authenticated do
      root 'predictions#index'
    end
  end

  resources :predictions, only: [:index, :show, :edit, :update]

  namespace :admin do
    resources :users, only: [:index, :edit, :update]
  end

end
