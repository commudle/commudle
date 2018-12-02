class AddMiniDescriptionToKommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :kommunities, :mini_description, :text
  end
end
