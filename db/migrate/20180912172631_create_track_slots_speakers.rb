class CreateTrackSlotsSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :track_slots_speakers do |t|
      t.references :track_slot, foreign_key: true
      t.references :data_form_entity_response_group, foreign_key: true

      t.timestamps
    end
  end
end
