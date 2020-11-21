class RemoveRoleColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :role_id
  end
end
