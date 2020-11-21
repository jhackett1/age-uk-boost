class AddNotificationPreferencesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notify_about_due_tasks, :boolean
    add_column :users, :notify_about_new_tasks, :boolean
  end
end
