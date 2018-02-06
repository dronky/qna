require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda {|u| u.admin?} do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  devise_scope :user do
    post '/register' => 'omniauth_callbacks#register'
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        #on: :collection means .../me without id
        get :me, on: :collection
      end
      resources :questions do
        resources :answers, shallow: true
      end
    end
  end

  root 'questions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :subscriptions

  resources :questions do
    resources :answers, shallow: true do
      patch :mark_as_best
      post :plus_vote
      post :minus_vote
      post :reset_votes, on: :member
      post :add_comment, on: :member
    end
    post :plus_vote, on: :member
    post :minus_vote, on: :member
    post :add_comment, on: :member
  end

  mount ActionCable.server => '/cable'
end
