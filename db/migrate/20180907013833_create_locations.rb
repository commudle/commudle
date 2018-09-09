class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.text :map_link, null: false

      t.timestamps
    end
  end
end
