class AddUserToEventDataFormEntityGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :event_data_form_entity_groups, :user, foreign_key: true
  end
end
