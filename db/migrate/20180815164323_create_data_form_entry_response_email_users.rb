class CreateDataFormEntryResponseEmailUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :data_form_entry_response_email_users do |t|
      t.integer :data_form_entity_response_id
      t.integer :registration_status_id
      t.integer :event_status_id
      t.integer :communication_email_id

      t.timestamps
    end

    add_foreign_key :data_form_entry_response_email_users, :data_form_entity_responses, foreign_key: true, index: true, :name => 'index_dfereu_response'

    add_foreign_key :data_form_entry_response_email_users, :registration_statuses, foreign_key: true, index: true, :name => 'index_dfereu_registration_status'

    add_foreign_key :data_form_entry_response_email_users, :event_statuses, foreign_key: true, index: true, :name => 'index_dfereu_event_status'

    add_foreign_key :data_form_entry_response_email_users, :communication_emails, foreign_key: true, index: true, :name => 'index_dfereu_communication_status'
  end
end
