class AddRegistrationTypeToDataFormEntity < ActiveRecord::Migration[5.2]
  def change
    add_reference :data_form_entities, :registration_type, foreign_key: true, index: true
  end
end
