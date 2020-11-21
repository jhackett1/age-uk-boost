class DropActiveStorage < ActiveRecord::Migration[5.2]
  def change
    drop_table :active_storage_attachments, force: :cascade
    drop_table :active_storage_blobs, force: :cascade
  end
end
