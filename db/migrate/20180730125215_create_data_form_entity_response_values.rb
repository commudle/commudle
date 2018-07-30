class CreateDataFormEntityResponseValues < ActiveRecord::Migration[5.2]
  def change
    create_table :data_form_entity_response_values do |t|
      t.integer :data_form_entity_response_id, null: false
      t.references :question, foreign_key: true, index: true, null: false
      t.text :text_response
      t.references :question_choice, foreign_key: true, index: true
      t.boolean :active, default: true

      t.timestamps
    end

    add_foreign_key :data_form_entity_response_values, :data_form_entity_responses, foreign_key: true, index: true, :name => 'index_dfe_response_values_on_dfe_response_id'
  end
end
