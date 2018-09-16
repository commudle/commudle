class EventLocationTrack < ApplicationRecord
  belongs_to :event
  belongs_to :event_location

  has_many :track_slots, dependent: :destroy
end
