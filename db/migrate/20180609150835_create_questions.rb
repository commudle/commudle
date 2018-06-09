class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.belongs_to :question_type, foreign_key: true, null: false
      t.belongs_to :data_form, foreign_key: true, null: false
      t.text :title, null: false

      t.timestamps
    end
  end
end
