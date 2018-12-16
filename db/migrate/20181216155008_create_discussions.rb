class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :topic, null: false
      t.text :description, null: false
      t.belongs_to :parent, polymorphic: true
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
