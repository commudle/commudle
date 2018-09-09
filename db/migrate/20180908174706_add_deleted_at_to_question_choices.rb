class AddDeletedAtToQuestionChoices < ActiveRecord::Migration[5.2]
  def change
    add_column :question_choices, :deleted_at, :datetime
    add_index :question_choices, :deleted_at
  end
end
