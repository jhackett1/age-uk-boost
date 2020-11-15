class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :client
  has_and_belongs_to_many :services
end
