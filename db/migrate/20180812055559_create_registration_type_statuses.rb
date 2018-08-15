class CreateRegistrationTypeStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_type_statuses do |t|
      t.references :registration_status, foreign_key: true, index: true
      t.references :registration_type, foreign_key: true, index: true

      t.timestamps
    end
  end
end
