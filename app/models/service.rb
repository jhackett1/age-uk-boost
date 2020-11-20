class Service < ApplicationRecord
    has_and_belongs_to_many :orders

    validates :name, presence: true

    def stripe_price
        ( price * 100 ).to_i
    end
end
