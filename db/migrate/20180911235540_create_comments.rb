class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: true, index: true
      t.belongs_to :commentable, polymorphic: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
