class AddPriceToService < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :price, :float
  end
end
