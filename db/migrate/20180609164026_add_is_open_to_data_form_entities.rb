class AddIsOpenToDataFormEntities < ActiveRecord::Migration[5.1]
  def change
    add_column :data_form_entities, :is_open, :boolean, default: false
  end
end
