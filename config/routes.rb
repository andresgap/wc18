Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'authentication' },
    skip: [:registrations, :passwords]

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    authenticated do
      root 'predictions#index'
    end
  end

  resources :rules, only: [:index]
  resources :predictions, only: [:index, :show, :update]
  resources :leaderboards, only: [:index]
  resources :myleaderboards, only: [:index, :new, :create, :edit, :update] do
    get 'leave'
    get 'leave_confirm'
    get 'invite'
    get 'invite_confirm'
    get 'join'
    get 'join_confirm'
  end

  namespace :admin do
    resources :matches, only: [:index, :edit, :update]
    resources :users, only: [:index, :edit, :update]
    resources :leaderboards, only: [:index, :edit, :update, :destroy] do
      get 'delete'
    end
  end

end
