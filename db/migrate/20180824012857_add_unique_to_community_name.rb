class AddUniqueToCommunityName < ActiveRecord::Migration[5.2]
  def change
    remove_index :kommunities, :name
    add_index :kommunities, :name, unique: true
    add_index :kommunities, :slug, unique: true
  end
end
