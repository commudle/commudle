class CreateFormResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :form_responses do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :data_form_entity, foreign_key: true, null: false
      # parent can be either choice or question
      t.belongs_to :parent, polymorphic: true, null: false

      t.timestamps
    end
  end
end
