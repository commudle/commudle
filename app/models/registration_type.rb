class RegistrationType < ApplicationRecord
  has_many :event_data_form_entity_groups

  has_many :registration_type_statuses
  has_many :registration_statuses, through: :registration_type_statuses

end