class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  passwordless_with :email

  geocoded_by :whole_address
  after_validation :geocode

  # associations
  has_many :tasks, foreign_key: "assignee_id", class_name: "Order"

  # validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :phone, presence: true
  validates :address, presence: true
  validates :postcode, presence: true
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
