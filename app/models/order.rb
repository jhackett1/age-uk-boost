class Order < ApplicationRecord

  belongs_to :client, foreign_key: "client_id", class_name: "User"
  belongs_to :assignee, foreign_key: "assignee_id", class_name: "User", optional: true

  has_and_belongs_to_many :services
  has_and_belongs_to_many :receipts

  def name
    id
  end
end
