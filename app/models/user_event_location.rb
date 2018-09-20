class UserEventLocation < ApplicationRecord
  belongs_to :user
  belongs_to :event_location
  belongs_to :event, optional: true

  default_scope { order(preference_order: :asc) }


  def self.set_preference(user, event_locations)

    event_locations.each do |key, val|
      ull = UserEventLocation.find_or_create_by(
                           user: user,
                           event_location_id: val.to_i
                        ).update(
                              preference_order: key.to_i
                        )
    end

  end


end
