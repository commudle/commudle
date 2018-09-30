class CreateSpeakerResources < ActiveRecord::Migration[5.2]
  def change
    create_table :speaker_resources do |t|
      t.references :data_form_entity_response_group, foreign_key: true
      t.text :session_details_links

      t.timestamps
    end
  end
end
