class AddTitleToSpeakerResources < ActiveRecord::Migration[5.2]
  def change
    add_column :speaker_resources, :title, :string
  end
end
