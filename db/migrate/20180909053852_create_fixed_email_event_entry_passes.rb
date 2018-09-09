class CreateFixedEmailEventEntryPasses < ActiveRecord::Migration[5.2]
  def change
    create_table :fixed_email_event_entry_passes do |t|
      t.references :event_entry_pass, foreign_key: true, index: true
      t.references :fixed_email, foreign_key: true, index: true

      t.timestamps
    end
  end
end
