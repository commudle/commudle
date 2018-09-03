class TrackSlot < ApplicationRecord
  belongs_to :event_location_track
  belongs_to :speaker, class_name: "DataFormEntityResponseGroup"
end
