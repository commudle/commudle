class RegistrationStatus < ApplicationRecord
  has_many :user_event_data_form_entity_response_groups

  has_many :registration_type_statuses
  has_many :registration_types, through: :registration_type_statuses

end