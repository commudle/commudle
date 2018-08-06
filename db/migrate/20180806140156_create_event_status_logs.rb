class CreateEventStatusLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :event_status_logs do |t|
      t.references :event, foreign_key: true, null: false, index: true
      t.references :event_status, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
