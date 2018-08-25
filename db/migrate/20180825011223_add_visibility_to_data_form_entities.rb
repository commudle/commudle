class AddVisibilityToDataFormEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :data_form_entities, :visibility, :integer, default: 0
  end
end
