class CreateFixedEmailEdfeGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :fixed_email_edfegs do |t|
      t.references :fixed_email, foreign_key: true
      t.references :user, foreign_key: true
      t.references :event_data_form_entity_group, foreign_key: true

      t.timestamps
    end
  end
end
