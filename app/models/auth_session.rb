class AuthSession < ApplicationRecord
  include BCrypt

  belongs_to :user

  validates :timeout_at, presence: true
  validates :expires_at, presence: true  
  validates :user_agent, presence: true  
  validates :token, presence: true

  scope :claimable, -> { where(claimed_at: nil) }
  scope :unexpired, -> { where("expires_at > ?", Time.current) }
  scope :before_timeout, -> { where("timeout_at > ?", Time.current) }

  def token
    @token ||= Password.new(token_digest)
  end

  def token=(new_token)
    self.token_digest = Password.create(new_token)
  end

end
