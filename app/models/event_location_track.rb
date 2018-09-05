class EventLocationTrack < ApplicationRecord
  belongs_to :event

  has_many :track_slots, dependent: :destroy
end
