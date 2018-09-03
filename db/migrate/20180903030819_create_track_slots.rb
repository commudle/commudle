class CreateTrackSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :track_slots do |t|
      t.references :event_location_track, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :session_title
      t.references :speaker_registration, foreign_key: { to_table: :data_form_entity_response_groups }

      t.timestamps
    end
  end
end
