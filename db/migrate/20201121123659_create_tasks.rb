class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :special_request
      t.references :user, foreign_key: true
      t.datetime :completed_at
      t.string :address
      t.string :postcode
      t.float :latitude
      t.float :longitude
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
