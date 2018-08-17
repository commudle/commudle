class UserEventDataFormEntityResponseGroup < ApplicationRecord
  # this model makes the form generic, the same form can be assigned to an event or any other thing as well
  belongs_to :event_data_form_entity_group
  belongs_to :registration_status

  has_many :data_form_entity_responses

end
