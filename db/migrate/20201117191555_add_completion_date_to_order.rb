class AddCompletionDateToOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :approved
    add_column :orders, :completed_at, :datetime
    add_column :orders, :approved_at, :datetime
  end
end
