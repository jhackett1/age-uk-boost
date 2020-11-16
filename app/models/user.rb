class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, class_name: "Order"
  has_many :orders
  belongs_to :role

  validates :email, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :postcode, presence: true

  # validate :postal_code_is_valid

  geocoded_by :postcode
  
  after_validation :geocode

  # def postal_code_is_valid
  #     parsed = UKPostcode.parse(postcode)
  #     unless parsed.full_valid?
  #         errors.add(:base, :invalid_postcode)
  #     end
  # end

  def display_name
    first_name + " " + last_name
  end

end
