class CreateDataForms < ActiveRecord::Migration[5.1]
  def change
    create_table :data_forms do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :kommunity, foreign_key: true, null: false
      t.string :name

      t.timestamps
    end
  end
end
