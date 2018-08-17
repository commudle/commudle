class EventDataFormEntityGroup < ApplicationRecord
  # extend FriendlyId
  # friendly_id :name, use: :slugged

  belongs_to :event
  belongs_to :registration_type
  belongs_to :user

  has_many :data_form_entities, as: :entity, dependent: :destroy
  has_many :data_form_entity_response_groups


end
