class CreateEventDataFormEntityGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :event_data_form_entity_groups do |t|
      t.string :name, null: false, index: true
      t.references :event, foreign_key: true, index: true, null: false

      t.timestamps

    end
  end
end
