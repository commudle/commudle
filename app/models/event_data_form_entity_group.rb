class EventDataFormEntityGroup < ApplicationRecord
  belongs_to :event
  has_many :data_form_entities, as: :entity
  belongs_to :registration_type


end
