class AddRegistrationStatusToDataFormEntityResponses < ActiveRecord::Migration[5.2]
  def change
    add_reference :data_form_entity_responses, :registration_status, foreign_key: true, index: true
  end
end
