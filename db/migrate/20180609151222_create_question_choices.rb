class CreateQuestionChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :question_choices do |t|
      t.belongs_to :question, foreign_key: true, null: false
      t.text :title, null: false

      t.timestamps
    end
  end
end
