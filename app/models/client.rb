class Client < ApplicationRecord
    has_many :orders

    validates :email, presence: true
    validates :phone, presence: true
    validates :address, presence: true
    validates :postcode, presence: true
end
