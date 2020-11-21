class AddUrgentToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :urgent, :boolean
  end
end
