class AddRoleRefToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :role
    add_reference :users, :role, foreign_key: true
  end
end
