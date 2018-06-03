class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name, index: true, null: false
      t.text :description
      t.datetime :start_time, index: true
      t.datetime :end_time, index: true
      t.references :kommunity, foreign_key: true, index: true

      t.timestamps
    end
  end
end
