class AddNewOrderReferences < ActiveRecord::Migration[5.2]
  def change

    remove_reference :orders, :client
    remove_reference :orders, :user
  
    add_reference :orders, :client, references: :users, index: true
    add_reference :orders, :assignee, references: :users, index: true

  end
end
