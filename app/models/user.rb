class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, foreign_key: "client_id", class_name: "Order"
  has_many :tasks, foreign_key: "assignee_id", class_name: "Order"
  has_many :receipts
  belongs_to :role

  validates :email, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :postcode, presence: true

  validate :postal_code_is_valid

  geocoded_by :whole_address
  
  after_validation :geocode

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

  def rough_distance
    if distance < 1
      "Less than a mile away"
    elsif (1 < distance) && (distance < 2)
      "About a mile away"
    else
      "About #{distance.round} miles away"
    end
  end

  scope :has_role, -> (name){ joins(:role).where("roles.name = ?", name)}
  scope :with_available_tasks, -> { where("orders.approved = TRUE AND assignee_id IS NULL") }
end
