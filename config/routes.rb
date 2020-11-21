Rails.application.routes.draw do

  namespace :admin do
      resources :tasks
      resources :users
      root to: "tasks#index"
    end
  passwordless_for :users, at: '/', as: :auth

  root to: "planner#index"

  resources "tasks", only: [:index, :show] do
    post "claim", to: "tasks#claim"
    post "done", to: "tasks#done"
  end

  resource "profile", only: [:show, :update]

end