class SpeakerResource < ApplicationRecord
  # only for speakers who are shortlisted for a session
  belongs_to :data_form_entity_response_group
  has_many :discussions, as: :parent


  delegate :user, :to => :data_form_entity_response_group, :allow_nil => true
  delegate :event, :to => :data_form_entity_response_group, :allow_nil => true


end
