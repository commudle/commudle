class AddEventLocationToEventLocationTracks < ActiveRecord::Migration[5.2]
  def change
    add_reference :event_location_tracks, :event_location, foreign_key: true
  end
end
