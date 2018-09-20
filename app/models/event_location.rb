class EventLocation < ApplicationRecord
  belongs_to :event
  belongs_to :location

  has_many :event_location_tracks
  has_many :user_event_locations

  default_scope { order(created_at: :asc) }
end
