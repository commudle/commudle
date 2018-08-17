class AddSlugToEventDataFormEntityGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :event_data_form_entity_groups, :slug, :string, unique: true
  end
end
