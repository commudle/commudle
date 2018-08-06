class AddRegistrationFormToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :registration_form, index: true
    add_foreign_key :events, :data_form_entities, column: :registration_form_id
  end
end
