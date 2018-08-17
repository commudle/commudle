class RemoveUserFromDataFormEntityResponses < ActiveRecord::Migration[5.2]
  def change
    remove_column :data_form_entity_responses, :user_id, :integer
  end
end
