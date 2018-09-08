class Location < ApplicationRecord

  has_many :event_locations
  has_many :events, through: :event_locations


  def url_escaped_address
    return URI.encode("#{self.name}  #{self.address}")
  end

end
