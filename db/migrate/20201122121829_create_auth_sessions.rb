class CreateAuthSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_sessions do |t|
      t.string :token, null: false
      t.datetime :claimed_at
      t.datetime :expires_at, null: false
      t.datetime :timeout_at, null: false
      t.references :user, foreign_key: true
      t.text :user_agent, null: false

      t.timestamps
    end

    drop_table :passwordless_sessions
  end
end
