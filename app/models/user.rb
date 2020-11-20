class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, foreign_key: "client_id", class_name: "Order", inverse_of: :client
  has_many :tasks, foreign_key: "assignee_id", class_name: "Order"
  has_many :receipts
  belongs_to :role

  accepts_nested_attributes_for :orders

  validates :email, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :postcode, presence: true

  validate :postal_code_is_valid

  geocoded_by :whole_address
  
  after_validation :geocode

  include PgSearch::Model
  
  pg_search_scope :search, against: [
      :email, 
      :first_name, 
      :last_name, 
      :address, 
      :postcode, 
      :phone
    ],
    using: {
      tsearch: { prefix: true }
    }

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

  scope :has_role, -> (name){ joins(:role).where("roles.name = ?", name)}
end
