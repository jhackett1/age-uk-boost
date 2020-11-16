Rails.application.routes.draw do

  root "clients#index"
  resources "clients", except: "edit"  

  devise_for :users

  namespace :volunteer do
    root "planner#index"
    resources "tasks", except: "edit"  
    resources "receipts", except: "edit"   
  end

  namespace :organiser do
    root "dashboard#index"  
    resources "orders", except: "edit"
    resources "services", except: "edit"
    resources "receipts", except: "edit"
    resources "users", except: "edit"
  end
  
end
