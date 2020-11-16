class Order < ApplicationRecord

  belongs_to :client, foreign_key: "client_id", class_name: "User"
  belongs_to :assignee, foreign_key: "assignee_id", class_name: "User", optional: true

  has_and_belongs_to_many :services
  has_and_belongs_to_many :receipts

  def name
    services.map{ |s| s.name }.join(", ").humanize
  end

  def total
    total = 0
    services.each do |s|
      total += s.price
    end
    total
  end

  scope :available, -> { where("approved = TRUE AND assignee_id IS NULL") }
end
