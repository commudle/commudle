class RemoveRegistrationTypeFromDataFormEntity < ActiveRecord::Migration[5.2]
  def change
    remove_column :data_form_entities, :registration_type_id, :string
  end
end
