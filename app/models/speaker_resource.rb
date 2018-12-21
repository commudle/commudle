class SpeakerResource < ApplicationRecord
  # only for speakers who are shortlisted for a session
  belongs_to :data_form_entity_response_group
  has_many :discussions, as: :parent

end
