class AddNameToDataFormEntities < ActiveRecord::Migration[5.1]
  def change
    add_column :data_form_entities, :name, :string
  end
end
