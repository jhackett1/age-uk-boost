class CreateServiceOrderJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_services, id: false do |t|
      t.belongs_to :order
      t.belongs_to :service
    end
  end
end
