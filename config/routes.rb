Rails.application.routes.draw do

  root "organiser/dashboard#index"

  namespace :organiser do
    root "dashboard#index"
    resources "clients", except: "edit"    
    resources "orders", except: "edit"
    resources "services", except: "edit"
    resources "users", except: "edit"
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
