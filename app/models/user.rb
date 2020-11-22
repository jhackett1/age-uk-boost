class User < ApplicationRecord

  phony_normalize :phone, default_country_code: 'GB'

  geocoded_by :whole_address
  after_validation :geocode

  # associations
  has_many :tasks
  has_one :auth_session

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, uniqueness: { case_sensitive: false }
  validate :postal_code_is_valid

  # methods
  def postal_code_is_valid
      parsed = UKPostcode.parse(postcode)
      unless parsed.full_valid?
          errors.add(:base, :invalid_postcode)
      end
  end

  def display_name
    first_name + " " + last_name || phone
  end

  def whole_address
    [address, postcode, "UK"].compact.join(', ')
  end

  # scopes
  scope :has_role, -> (name){ joins(:role).where("roles.name = ?", name)}
end
