class RemoveRegistrationStatusFromDataFormEntityResponse < ActiveRecord::Migration[5.2]
  def change
    remove_column :data_form_entity_responses, :registration_status_id, :string
  end
end
