Rails.application.routes.draw do

  root "requests#index"
  resources "requests", except: "edit"  

  devise_for :users

  namespace :volunteer do
    root "planner#index"
    resources "tasks", except: "edit" do
      post "done", to: "tasks#done"
    end
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
