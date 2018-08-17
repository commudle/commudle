class RenameUserEventDataFormEntityResponseGroup < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :user_event_data_form_entity_response_groups, :data_form_entity_response_groups
  end

  def self.down
    rename_table :data_form_entity_response_groups, :user_event_data_form_entity_response_groups
  end
end
