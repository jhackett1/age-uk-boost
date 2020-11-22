class AddDefaultsToNotifications < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :notify_about_new_tasks, :boolean, default: true
    change_column :users, :notify_about_due_tasks, :boolean, default: true
  end
end
