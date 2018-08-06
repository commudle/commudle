class CreateDataFormEntityResponseRegistrationStatusLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :data_form_entity_response_registration_status_logs do |t|
      t.integer :data_form_entity_response_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_foreign_key :data_form_entity_response_registration_status_logs, :data_form_entity_responses, foreign_key: true, index: true, :name => 'index_data_form_entity_response_reg_status'

    add_foreign_key :data_form_entity_response_registration_status_logs, :users, foreign_key: true, index: true, :name => 'index_data_form_entity_response_reg_status_user'

  end
end
