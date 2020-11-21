class User < ApplicationRecord

  include TwilioWrapper

  def notify
    send_sms(self.phone)
  end

  passwordless_with :email

  geocoded_by :whole_address
  after_validation :geocode

  # associations
  has_many :tasks

  # validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :postal_code_is_valid

  # methods
  def postal_code_is_valid
      parsed = UKPostcode.parse(postcode)
      unless parsed.full_valid?
          errors.add(:base, :invalid_postcode)
      end
  end

  def display_name
    first_name + " " + last_name
  end

  def whole_address
    [address, postcode, "UK"].compact.join(', ')
  end

  # scopes
  scope :has_role, -> (name){ joins(:role).where("roles.name = ?", name)}
end
