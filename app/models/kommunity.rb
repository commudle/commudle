class Kommunity < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  has_many :data_forms
  has_many :user_roles_users


  has_one_attached :logo_image


  # get the nearest event which took place or has to take place
  def nearest_events

    events = Event.upcoming(kommunity_id: self.id)
    if events.blank?
      events = Event.recent_past(kommunity_id: self.id)
    end

    return events
  end


end
