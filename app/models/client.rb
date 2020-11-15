class Client < ApplicationRecord
    has_many :orders

    validates :email, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :postcode, presence: true

    validate :postal_code_is_valid

    geocoded_by :postcode
    
    after_validation :geocode

    def postal_code_is_valid
        parsed = UKPostcode.parse(postcode)
        unless parsed.full_valid?
            errors.add(:base, :invalid_postcode)
        end
    end
end
