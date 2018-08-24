class CreateEventEntryPasses < ActiveRecord::Migration[5.2]
  def change
    create_table :event_entry_passes do |t|
      t.references :event, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :unique_code, null: false
      t.references :created_by, foreign_key: { to_table: :users }
      t.boolean :attendance, default: false, null: false
      t.boolean :uninvited, default: false, null: false
      t.boolean :on_the_spot_registration, default: false, null: false

      t.timestamps
    end

    add_index :event_entry_passes, [:event_id, :user_id], unique: true
    add_index :event_entry_passes, [:event_id, :unique_code], unique: true
  end
end
