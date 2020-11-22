Rails.application.routes.draw do

  get "sign-in", to: "auth#new", as: :sign_in
  post "sign-in", to: "auth#create"
  post "sign-in/token", to: "auth#show"
  delete "sign-out", to: "auth#destroy", as: :sign_out

  root to: "planner#index"
  resources :tasks, only: [:index, :show] do
    post "claim", to: "tasks#claim"
    post "done", to: "tasks#done"
  end
  resource :profile, only: [:show, :update]

  namespace :admin do
    root to: "tasks#index"
    resources :tasks
    resources :users
    resources :auth_sessions
  end

end