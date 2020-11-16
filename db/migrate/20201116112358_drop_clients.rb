class DropClients < ActiveRecord::Migration[5.2]
  def change
    drop_table :clients, force: :cascade
  end
end
