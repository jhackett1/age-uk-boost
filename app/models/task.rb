class Task < ApplicationRecord
  belongs_to :user, optional: true

  geocoded_by :postcode
  after_validation :geocode

  scope :claimed_by, -> (user_id){ where(user: user_id) }  
  scope :unclaimed, -> { where(user: nil) }

  scope :incomplete, -> { where(completed_at: nil) }  
  scope :recently_completed, -> { where("completed_at >= ?", DateTime.now - 12.hours) }

end
