class AddFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :client, foreign_key: true
    add_column :orders, :approved, :boolean
  end
end
