class RegistrationType < ApplicationRecord
  has_many :data_form_entities

  has_many :registration_type_statuses
  has_many :registration_statuses, through: :registration_type_statuses

end