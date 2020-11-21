expiry_minutes = ENV['LINK_EXPIRY_MINUTES'] || 30
Passwordless.timeout_at = lambda { expiry_minutes.to_i.minutes.from_now }