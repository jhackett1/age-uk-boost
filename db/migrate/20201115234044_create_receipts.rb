class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.references :user, foreign_key: true
      t.float :total

      t.timestamps
    end

    create_table :orders_receipts, id: false do |t|
      t.belongs_to :order
      t.belongs_to :receipt
    end
  end
end
