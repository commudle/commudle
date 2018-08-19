class AddRsvpTokenToDataFormEntityResponseGroup < ActiveRecord::Migration[5.2]
  def change
    enable_extension "uuid-ossp" unless extension_enabled?("uuid-ossp")
    add_column :data_form_entity_response_groups, :rsvp_token, :uuid, default: 'uuid_generate_v4()'
  end
end
