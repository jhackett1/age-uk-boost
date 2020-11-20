class AddCommentToReceipt < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :comment, :text
  end
end
