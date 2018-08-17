class AddDataFormEntityResponseGroupToDataFormEntityResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :data_form_entity_responses, :data_form_entity_response_group_id, :integer

    add_foreign_key :data_form_entity_responses, :data_form_entity_response_groups, foreign_key: true, index: true, :name => 'index_user_repsponse_group_event_dfe_group'
  end
end
