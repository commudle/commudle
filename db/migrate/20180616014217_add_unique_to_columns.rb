class AddUniqueToColumns < ActiveRecord::Migration[5.1]
  def change
    remove_index :question_types, :name
    add_index :question_types, :name, :unique => true
    add_index :user_roles, :name, :unique => true
  end
end
