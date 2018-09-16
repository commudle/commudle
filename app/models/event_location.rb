class EventLocation < ApplicationRecord
  belongs_to :event
  belongs_to :location

  has_many :event_location_tracks
end
