class CreateUserEventDataFormEntityResponseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_event_data_form_entity_response_groups do |t|
      t.integer :event_data_form_entity_group_id
      t.integer :registration_status_id

      t.timestamps
    end

    add_foreign_key :user_event_data_form_entity_response_groups, :event_data_form_entity_groups, foreign_key: true, index: true, :name => 'index_user_repsponse_group_event_dfe_group'

    add_foreign_key :user_event_data_form_entity_response_groups, :registration_statuses, foreign_key: true, index: true, :name => 'index_user_repsponse_group_event_reg_status'

  end
end
