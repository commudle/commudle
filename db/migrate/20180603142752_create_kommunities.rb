class CreateKommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :kommunities do |t|
      t.string :name, null: false, index: true
      t.text :about
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
