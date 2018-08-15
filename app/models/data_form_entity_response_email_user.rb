class DataFormEntityResponseEmailUser < ApplicationRecord
  belongs_to :communication_email
  belongs_to :data_form_entity_response
  belongs_to :registration_status
  belongs_to :event_status

end
