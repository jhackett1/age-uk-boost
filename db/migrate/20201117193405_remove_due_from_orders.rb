class RemoveDueFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :due
  end
end
