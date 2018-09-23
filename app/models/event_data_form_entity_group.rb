class EventDataFormEntityGroup < ApplicationRecord
  # extend FriendlyId
  # friendly_id :name, use: :slugged

  belongs_to :event
  belongs_to :registration_type
  belongs_to :user

  has_many :data_form_entities, as: :entity, dependent: :destroy
  has_many :data_form_entity_response_groups


  validates_length_of :data_form_entities, maximum: 1

  # scopes
  default_scope { includes(:registration_type, :event) }

  ##



  def registration_type? (registration_type_names)
    return registration_type_names.include? self.registration_type.name
  end



  def registration_status_counts
    statuses = Hash.new
    dfergs = self.data_form_entity_response_groups
    self.registration_type.registration_type_statuses.includes(:registration_status).each do |regst|
      statuses[regst.registration_status.name.to_s] = {
          count: dfergs.select{|dferg| dferg.registration_status_id == regst.registration_status.id}.length,
          registration_status_id: regst.registration_status_id
      }

    end

    return statuses
  end


end
