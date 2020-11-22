class StoreTokenDigestOnAuthSessions < ActiveRecord::Migration[5.2]
  def change
    rename_column :auth_sessions, :token, :token_digest
  end
end
