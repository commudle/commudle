class RemoveRegistrationFormIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :registration_form_id, :integer
  end
end
