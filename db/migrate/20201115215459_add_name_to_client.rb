class AddNameToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :name, :string
  end
end
