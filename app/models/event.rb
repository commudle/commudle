class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :kommunity
  belongs_to :user

  has_many :data_form_entities, as: :entity



end
