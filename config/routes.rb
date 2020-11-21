Rails.application.routes.draw do

  root "planner#index"
  resources "tasks", except: "edit" do
    post "done", to: "tasks#done"
  end  

  passwordless_for :users

end