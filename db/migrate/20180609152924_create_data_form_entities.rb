class CreateDataFormEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :data_form_entities do |t|
      t.belongs_to :data_form, foreign_key: true, null: false
      t.belongs_to :entity, polymorphic: true, null: false

      t.timestamps
    end
  end
end
