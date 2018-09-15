class DataFormEntity < ApplicationRecord
  # this model makes the form generic, the same form can be assigned to an event or any other thing as well
  # extend FriendlyId
  # friendly_id :name, use: :slugged
  belongs_to :data_form
  belongs_to :entity, polymorphic: true
  has_many :questions, through: :data_form
  has_many :data_form_entity_responses

  enum visibility: [:yet_to_announce, :open, :attendees, :closed]

  def can_fill_event_form(user)
    if self.open? || (user.role?(:system_administrator, nil) || user.role?(:organizer, self.entity.event.kommunity_id)) || (self.attendees? && self.entity.event.event_entry_passes.where(user: user).length > 0)
      return true
    end
    return false
  end

end
