class RemoveKindFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :kind
  end
end
