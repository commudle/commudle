class AddDeletedAtToEventDataFormEntityGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :event_data_form_entity_groups, :deleted_at, :datetime
    add_index :event_data_form_entity_groups, :deleted_at
  end
end
