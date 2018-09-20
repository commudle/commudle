class CreateUserEventLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_event_locations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :event_location, foreign_key: true, null: false
      t.integer :preference_order
      t.boolean :is_selected, default: false

      t.timestamps
    end
  end
end
