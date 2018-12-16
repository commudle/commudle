class CreateUserMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :user_messages do |t|
      t.belongs_to :parent, polymorphic: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
