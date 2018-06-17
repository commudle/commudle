class Event < ApplicationRecord
  belongs_to :kommunity
  belongs_to :user

  has_many :data_form_entities, as: :entity
end
