class RenameFormResponsesToDataFormEntityResponses < ActiveRecord::Migration[5.2]
  def change
    remove_index :data_form_entity_responses, name: "index_form_responses_on_parent_type_and_parent_id"
    remove_column :form_responses, :parent_type
    remove_column :form_responses, :parent_id
    rename_table :form_responses, :data_form_entity_responses
  end
end
