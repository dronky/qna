Rails.application.routes.draw do
  devise_for :users

  root 'questions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
