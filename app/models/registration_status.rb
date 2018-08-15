class RegistrationStatus < ApplicationRecord
  has_many :data_form_entity_responses

  has_many :registration_type_statuses
  has_many :registration_types, through: :registration_type_statuses

end