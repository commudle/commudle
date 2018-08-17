class AddUniqueToNameAndEventInDfeGroups < ActiveRecord::Migration[5.2]
  def change
    add_index :event_data_form_entity_groups, [:name, :event_id], unique: true
  end
end
