class CreateEventUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :event_updates do |t|
      t.references :event, foreign_key: true
      t.text :details
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
