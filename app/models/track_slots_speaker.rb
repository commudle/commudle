class TrackSlotsSpeaker < ApplicationRecord
  belongs_to :track_slot
  belongs_to :data_form_entity_response_group
end
