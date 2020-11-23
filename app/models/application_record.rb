class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def has_coordinates?
    latitude && longitude
  end
end
