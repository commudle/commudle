class CreateEventLocationTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :event_location_tracks do |t|
      t.string :name, null: false
      t.text :description
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
