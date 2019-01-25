class AddDescriptionToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :description, :text
  end
end
