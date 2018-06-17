class CreateEventUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :event_users do |t|
      t.belongs_to :event, foreign_key: true, null: false
      t.belongs_to :user, foreign_key: true, null: false
      t.boolean :shortlisted, default: false
      t.boolean :rsvp, default: false
      t.boolean :attended, default: false

      t.timestamps
    end
  end
end
