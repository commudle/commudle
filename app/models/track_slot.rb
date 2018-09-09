class TrackSlot < ApplicationRecord
  belongs_to :event_location_track
  belongs_to :speaker_registration, class_name: "DataFormEntityResponseGroup", optional: true


  def start_time
    self[:start_time].blank? ? Time.now : self[:start_time].in_time_zone(self.event_location_track.event.timezone)

  end

  def end_time
    self[:end_time].blank? ? Time.now : self[:end_time].in_time_zone(self.event_location_track.event.timezone)

  end
end
