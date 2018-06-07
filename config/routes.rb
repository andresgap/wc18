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

  resources :faq, only: [:index]
  resources :predictions, only: [:index, :show, :update]
  resources :leaderboards, only: [:index, :new, :create, :edit, :update] do
    collection do
      get 'manage'
    end
    member do
      get 'leave'
      get 'leave_confirm'
      get 'members'
      get 'members_confirm'
    end
    resources :invitations, only: [:new, :create] do
      member do
        get 'accept'
        get 'reject'
      end
    end
  end

  namespace :admin do
    resources :matches, only: [:index, :edit, :update] do
      member do
        get 'points'
      end
    end
    resources :users, only: [:index, :edit, :update]
    resources :leaderboards, only: [:index, :edit, :update, :destroy] do
      get 'delete'
    end
  end

end
