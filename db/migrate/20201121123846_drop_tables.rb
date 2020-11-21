class DropTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :orders, force: :cascade
    drop_table :receipts, force: :cascade
    drop_table :services, force: :cascade
    drop_table :orders_receipts, force: :cascade
    drop_table :orders_services, force: :cascade
    drop_table :roles, force: :cascade
  end
end
