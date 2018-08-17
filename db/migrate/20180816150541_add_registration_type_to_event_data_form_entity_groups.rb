class AddRegistrationTypeToEventDataFormEntityGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :event_data_form_entity_groups, :registration_type, foreign_key: true, index: true
  end
end
