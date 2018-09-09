class CreateEventLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :event_locations do |t|
      t.references :event, foreign_key: true, null: false, index: true
      t.references :location, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
