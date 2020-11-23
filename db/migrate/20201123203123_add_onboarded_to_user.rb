class AddOnboardedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :onboarded_at, :datetime
  end
end
