class CreateFixedEmailDfeResponseGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :fixed_email_dfe_response_groups do |t|
      t.integer :data_form_entity_response_group_id, null: false
      t.references :fixed_email, foreign_key: true, index: true, null: false
      t.timestamps
    end

    add_foreign_key :fixed_email_dfe_response_groups, :data_form_entity_response_groups, foreign_key: true, index: true, :name => 'index_fixed_email_dfe_group'
  end
end
