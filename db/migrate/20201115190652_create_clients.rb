class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :email
      t.string :phone
      t.string :address
      t.string :postcode
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
