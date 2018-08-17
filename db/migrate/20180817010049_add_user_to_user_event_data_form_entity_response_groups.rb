class AddUserToUserEventDataFormEntityResponseGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_event_data_form_entity_response_groups, :user, foreign_key: true, index: true, name: "index_uedferg_user"
  end
end
