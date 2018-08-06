class CreateRegistrationStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_statuses do |t|
      t.string :name, null: false, index: true
      t.timestamps
    end
  end
end
